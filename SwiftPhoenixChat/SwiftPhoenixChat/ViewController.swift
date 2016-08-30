//
//  ViewController.swift
//  SwiftPhoenixChat
//
//  Created by David Stump on 9/1/16.
//  Copyright © 2016 David Stump. All rights reserved.
//

import UIKit
import SwiftPhoenixClient

class ViewController: UIViewController {
  @IBOutlet weak var chatView: UITextView!
  @IBOutlet weak var messageField: UITextField!
  @IBOutlet weak var userField: UITextField!
  @IBOutlet weak var sendButton: UIButton!
  
  let socket = Phoenix.Socket(domainAndPort: "localhost:4000", path: "socket", transport: "websocket")
  var topic: String? = "rooms:lobby"
  
  @IBAction func sendMessage(sender: AnyObject) {
    let message = Phoenix.Message(message: ["user":userField.text!, "body": messageField.text!])
    let payload = Phoenix.Payload(topic: topic!, event: "new:msg", message: message)
    socket.send(payload)
    messageField.text = ""
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Join the socket and establish handlers for users entering and submitting messages
    socket.join(topic: topic!, message: Phoenix.Message(subject: "status", body: "joining")) { channel in
      let chan = channel as! Phoenix.Channel
      
      chan.on("join") { message in
        self.chatView.text = "You joined the room.\n"
      }
      
      chan.on("new:msg") { message in
        guard let message = message as? Phoenix.Message,
          let username = message.message?["user"],
          let body     = message.message?["body"] else {
            return
        }
        let newMessage = "[\(username!)] \(body!)\n"
        let updatedText = self.chatView.text.stringByAppendingString(newMessage)
        self.chatView.text = updatedText
      }
      
      chan.on("user:entered") { message in
        let username = "anonymous"
        let updatedText = self.chatView.text.stringByAppendingString("[\(username) entered]\n")
        self.chatView.text = updatedText
      }
      
      chan.on("error") { message in
        guard let message = message as? Phoenix.Message,
          let body = message.message?["body"] else {
            return
        }
        let newMessage = "[ERROR] \(body!)\n"
        let updatedText = self.chatView.text.stringByAppendingString(newMessage)
        self.chatView.text = updatedText
      }
    }
  }
}

