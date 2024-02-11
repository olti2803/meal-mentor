//
//  TrackingView.swift
//  meal-mentor
//
//  Created by Olti Gjoni on 2/10/24.
//
import SwiftUI
import OpenAI

struct Message: Identifiable {
    var id: UUID = .init()
    var content: String
    var isUser: Bool
}

class ChatController: ObservableObject {
    @Published var messages: [Message] = []
    let openAI = OpenAI(apiToken: "")
    //add your key here
    
    func sendNewMessage(content: String) {
        let userMessage = Message(content: content, isUser: true)
        self.messages.append(userMessage)
        getBotReply()
    }
    
    func getBotReply() {
        
        openAI.chats(query: .init(model: .gpt3_5Turbo,
                                  messages: self.messages.map({Chat(role: .user, content: $0.content)}))) { result in
            switch result {
            case .success(let success):
                guard let choice = success.choices.first else {
                    return
                }
                let message = choice.message.content
                DispatchQueue.main.async {
                    self.messages.append(Message(content: message ?? "", isUser: false))
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}

struct ChattingView: View {
    @StateObject var chatController = ChatController()
    @State var string: String = ""

    var body: some View {
        // GestureDetector to detect taps and dismiss keyboard
        GestureDetector {
            VStack {
                ScrollView {
                    ForEach(chatController.messages) { message in
                        MessageView(message: message).padding(5)
                    }
                }
                HStack {
                    TextField("Message...", text: $string)
                        .padding(5)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(15)
                    Button {
                        chatController.sendNewMessage(content: string)
                        string = ""
                    } label: {
                        Image(systemName: "paperplane")
                    }
                }
                .padding()
            }
        }
    }
}

struct GestureDetector<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            Color.clear.contentShape(Rectangle()).onTapGesture { hideKeyboard() }
            content
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct MessageView: View {
    var message: Message
    var body: some View {
        Group {
            if message.isUser {
                HStack {
                    Spacer()
                    Text(message.content).padding().background(Color.accentColor).foregroundColor(Color.white)
                }
            } else {
                HStack {
                    Text(message.content).padding().background(Color.black).foregroundColor(Color.white)
                    Spacer()
                }
            }
        }
    }
}

struct ChattingView_Previews: PreviewProvider {
    static var previews: some View {
        ChattingView()
    }
}

