//
//  ContentView.swift
//  BucketList
//
//  Created by Bo Zhong on 6/5/24.
//

import SwiftUI
import MapKit
import LocalAuthentication
import WebKit

struct YoutubeView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: URL(string: "https://youtube.com")!)
        uiView.load(request)
    }
}

struct ContentView: View {
    @State private var isUnlocked: Bool = false
    @State private var isShowingYoutube: Bool = false
    
    var body: some View {
        NavigationStack {
            Button(action: {
                isShowingYoutube.toggle()
            }, label: {
                HStack {
                    Image(systemName: "play")
                    Text("Youtube")
                }
            })
            .sheet(isPresented: $isShowingYoutube, content: {
                YoutubeView()
            })
        }
    }
    
    func authenticate() {
        let context: LAContext = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                if success {
                    //authenticated successfully
                    isUnlocked = true
                } else {
                    //there was a problem
                }
            }
        } else {
            
        }
    }
}

#Preview {
    ContentView()
}
