<template>
  <div class="comment-wrapper mb-10" id="commentsform">
    <button id="" v-on:click="timecount">時間確認</button>
    <p class="comment-list">コメント一覧</p>
    <div class="comments">
      <div class="chatcontainer" v-for="comment in comments">
        <img src="https://www.w3schools.com/w3images/bandmember.jpg" alt="Avatar">
        <p>{{ comment.username }}</p>
        <p>{{ comment.content }}</p>
        <span class="time-right">{{ comment.current_time }}</span>
      </div>
    </div>
    <form>
      <textarea class="form-control" row=5 v-model="postdata.content"></textarea>
      <div class="btn btn-success float-right mt-1" id="postbtn" v-on:click="PostComment">
        <i class="far fa-comments"></i> コメントする
      </div>
    </form>
  </div>
</template>

<script>
  import Vue from 'vue';
  import axios from 'axios';
  export default{
    props: ['userId','postId','userName'],
    data: function(){
      return{
        postdata:{
          current_time: 0,
          content: '',
          user_id: Object.values(this.userId)[0],
          username: Object.values(this.userName)[0],
          post_id: Object.values(this.postId)[0],
        },
        comments: [],
      }
    },
    mounted: function(){
      this.viewComments();
    },
    methods:{
      viewComments(){
        //console.log(`${Object.values(this.postId)}`);
        axios.get(`../api/v1/comments/${Object.values(this.postId)}`).then(
          (res) =>{
          for(var i = 0; i < res.data.postdata.length; i++){
            this.comments.push(res.data.postdata[i]);
          }
        },(error) => {
          console.log(error);
        });

        var tag = document.createElement('script');
        tag.src = "https://www.youtube.com/iframe_api";
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
        window.onYouTubeIframeAPIReady = function() {
        Vue.prototype.$player = new YT.Player('player', {
        });
        //console.log(Vue.prototype.$player);
        }
      }, 
      timecount: function(){
        console.log("test");
        var current_time_btn = document.getElementById('cntbtn');
        var currentTime = Vue.prototype.$player.getCurrentTime();
        console.log(currentTime);
      },
      PostComment: function(){

        var currentTime = Vue.prototype.$player.getCurrentTime();
        console.log(currentTime);
        console.log(Vue.prototype.$player);
        this.postdata.current_time = currentTime;
        

        //送信をする際の描画用
        let nowdata = null;
        if(!this.userId) return;
        axios.post('../api/v1/comments',{postdata: this.postdata}).then((res) =>{
          nowdata = {
            current_time: this.postdata.current_time,
            content: this.postdata.content,
            user_id: Object.values(this.userId)[0],
            post_id: Object.values(this.postId)[0],
            username: Object.values(this.userName)[0]
          }
          console.log(this.postdata.current_time);
          this.comments.push(nowdata);
          this.postdata.content = null;
        },(error) =>{
          console.log(error);
        });
      },
    }
  }

</script>

<style>
  
</style>