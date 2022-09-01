const functions = require("firebase-functions");
const admin = require("firebase-admin");


admin.initializeApp();


exports.onOrderCreate = functions.firestore.document("orders/{orderId}").onCreate((res, context) => {
    var order = res.data();
    console.log(order);

    return admin.firestore().collection("settings").doc("store").get().then((res) => {
        console.log(res.data());
        var token = res.data().pushToken;
        return sendMessage(token, "New Order Received", "Total Items:" +order.itemCount+ " Value:" + order.cartTotal);
    }).catch((e) => {
        return false;

    });

});


exports.onOrderComplete = functions.firestore.document("orders/{orderId}").onUpdate((res, context) => {
    var order = res.after.data();
    console.log(order);

    if(order.status == "COMPLETED") {
    return admin.firestore().collection("accounts").doc(order.userId).get().then((res) => {
        console.log(res.data());
        var token = res.data().pushToken;
        return sendMessage(token, "Your Order is Completed!", "Total Items:" +order.itemCount+ " Value:" + order.cartTotal);
    }).catch((e) => {
        return false;

    });
  }
  else
  {
      return false;
  }


});

function sendMessage(token, title, message) {
    return admin.messaging().sendToDevice(token, {
        notification: {
            title: title,
            message: message,
            sound: "default"
        },
    });
}




/*
admin.firestore().collection('mail').add({
    to: 'raine',
    message: {
      subject: 'Hello from Firebase!',
      text: '$title',
    },
  })
*/

/*
function sendMessage( totken, title, message) {
    returnadmin.firestore().collection('mail').add({
        to: 'raineeraj185@gmail.com',
        message: {
          subject: 'Hello from Firebase!',
          text: '$title',
        },
      });
}
*/