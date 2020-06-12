
# json.array! @comments, :id, :current_time, :content, :user_id , :post_id




  # apiでのデータ公開
  json.set! :postdata do
    json.array! @comments do |comment|
      json.id               comment.id
      json.current_time     comment.current_time
      json.content          comment.content
      json.user_id          comment.user_id
      json.username         comment.user.name
      json.post_id          comment.post_id
      # 次のコードと同じ処理
      # json.extract! comment, :id, :current_time, :content, :user_id , :post_id
    end
  end
