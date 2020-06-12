/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue'


document.addEventListener('DOMContentLoaded', () => {
  var app = new Vue({
    el:"#app",  //vueのインスタンスが紐づくDOM要素ののセレクタ
    data:{      //ここで定義した値がv-model="hoge"や{{hoge}}の初期値に反映される
      url:"http://127.0.0.1/",//v-model="url"の初期値
      param:"{}",             //v-model="param"の初期値
      result:"...."           //v-model="result"の初期値
    },
    methods:{//v-on:click="hoge"などのイベントに紐づく関数定義
      post: function(){ //v-on:click="post"時の処理
        //Axiosを使ったAJAX
        //リクエスト時のオプションの定義
        config = {
          headers:{
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type':'application / x-www-form-urlencoded'
          },
          withCredentials:true,
        }
        //vueでバインドされた値はmethodの中ではthisで取得できる
        param = JSON.parse(this.param)

        //Ajaxリクエスト
        /*
          Axiosはプロミスベースのモジュールなので
　　　　　　　.thenや.catchを使う。
　　　　　　　.then((res => {}))の内側ではスコープが違うので
　　　　　　　Vueでバインドされた値をthisでは取れない
        */
        axios.post(this.url,,param,config)
        .then(function(res){
          //vueにバインドされている値を書き換えると表示に反映される
          app.result = res.data
          console.log(res)
        })
        .catch(function(res){
          //vueにバインドされている値を書き換えると表示に反映される
          app.result = res.data
          console.log(res)
        })
      }
    }
  })
})


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the project is using turbolinks, install 'vue-turbolinks':
//
// yarn add vue-turbolinks
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: () => {
//       return {
//         message: "Can you say hello?"
//       }
//     },
//     components: { App }
//   })
// })
