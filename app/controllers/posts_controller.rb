
class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create]

  def index
    @posts = Post.all
    if user_signed_in?
      @user = current_user.id
    end
  end

  def new
    flash[:new_post] = "ログイン済ユーザーのみ投稿できます" unless user_signed_in?
  end
  
  def create
    @post = Post.new()
    post_url = params[:post].to_s
    regex_url = post_url.scan(/(?:youtube\.com\/\S*(?:(?:\/e(?:mbed))?\/|watch\?(?:\S*?&?v\=))|youtu\.be\/)([a-zA-Z0-9_-]{6,11})/)
    # render plain:regex_url.inspect
    if regex_url.empty? == false
      url_key = regex_url[0][0]
      jsonURL = "https://www.googleapis.com/youtube/v3/videos?id=#{url_key}&key=#{Rails.application.credentials.youtubeAPI}&part=snippet"
      objs = JSON.parse(open(jsonURL).read)
      
      
      title = objs['items'][0]['snippet']['localized']['title']
      description = objs['items'][0]['snippet']['localized']['description']
      if objs['items'][0]['snippet']['thumbnails']['maxres']['url']
        thumbnail = objs['items'][0]['snippet']['thumbnails']['maxres']['url']
      elsif objs['items'][0]['snippet']['thumbnails']['standard']['url']
        thumbnail = objs['items'][0]['snippet']['thumbnails']['standard']['url']
      elsif objs['items'][0]['snippet']['thumbnails']['high']['url']
        thumbnail = objs['items'][0]['snippet']['thumbnails']['high']['url']
      elsif objs['items'][0]['snippet']['thumbnails']['medium']['url']
        thumbnail = objs['items'][0]['snippet']['thumbnails']['medium']['url']
      elsif objs['items'][0]['snippet']['thumbnails']['default']['url']
        thumbnail = objs['items'][0]['snippet']['thumbnails']['default']['url']
      end
      # render plain:url_key.inspect
      @post.url = url_key
      @post.title = title
      @post.description = description
      @post.thumbnail = thumbnail
      @post.user_id = current_user.id

      if @post.save
        flash[:post_success] = '動画投稿されました。' 
        redirect_to posts_path
      else
        flash[:post_Failure] = '動画投稿できませんでした。'
        redirect_to  new_post_path
      end
    else
      flash[:post_notURL] = 'YoutubeのURLではありません。'
      redirect_to  new_post_path
    end
  
      
  
      # postの中にchannelIDとチャンネルサムネのカラム作成必要あり
      
      # render plain:objs.inspect
      # render :xml => objs
      # render plain:title.inspect
      # render plain:title.inspect
  end
  
  def show
    @post = Post.find_by(url: params[:id])
    @comments = Comment.where(post_id: @post.id)
  end
  
    # ダブルクオーテーション除去
    # def cut_dbquotation(text)
    #   # return text.gsub(/‟.*?”/, '')
    #   return text
    # end
  
  
end
