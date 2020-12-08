
import socket from "./socket"

let chatRoomTitle = document.getElementById("chat-room-title")

if (chatRoomTitle) {
  let chatRoomName = chatRoomTitle.dataset.chatRoomName
  let channel = socket.channel(`chat_room:${chatRoomName}`, {})

  let messageForm = document.getElementById("new-message-form")
  let messageInput = document.getElementById("message")
  let messagesContainer = document.querySelector("[data-role='messages']")

  channel.on("new_message", payload => {
    let messageItem = document.createElement("li")
    messageItem.dataset.test = "message"
    messageItem.innerHTML = payload.body
    messagesContainer.appendChild(messageItem)
  })

  messageForm.addEventListener("submit", event => {
    event.preventDefault()
    channel.push("new_message", { body: messageInput.value })
    event.target.reset()
  })

  channel.join()
}
