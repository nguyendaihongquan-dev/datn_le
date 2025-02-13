const { onDocumentCreated } = require("firebase-functions/firestore");
const { initializeApp } = require("firebase-admin/app");
const { getMessaging } = require("firebase-admin/messaging");

initializeApp();

exports.myFunction = onDocumentCreated("chat/{messageId}", async (event) => {
  const snapshot = event.data;
  if (!snapshot) {
    console.log("No data found");
    return;
  }

  try {
    await getMessaging().send({
      notification: {
        title: snapshot.data().username,
        body: snapshot.data().text,
      },
      data: {
        click_action: "FLUTTER_NOTIFICATION_CLICK",
      },
      topic: "chat",
    });
    console.log("Notification sent successfully!");
  } catch (error) {
    console.error("Error sending notification:", error);
  }
});
