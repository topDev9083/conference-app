importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js');
firebase.initializeApp({
    apiKey: "AIzaSyDP2jYJOfzQRgZ5Qf4O9kGbbFE6IDgd9Ag",
    authDomain: "boxwood-airport-193606.firebaseapp.com",
    databaseURL: "https://boxwood-airport-193606.firebaseio.com",
    projectId: "boxwood-airport-193606",
    storageBucket: "boxwood-airport-193606.appspot.com",
    messagingSenderId: "156501342149",
    appId: "1:156501342149:web:0dee69f2fa7259f0a6fdac",
    measurementId: "G-841C32SET8"
});
const messaging = firebase.messaging();
