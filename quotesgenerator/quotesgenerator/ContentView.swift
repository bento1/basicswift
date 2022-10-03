//
//  ContentView.swift
//  quotesgenerator
//
//  Created by Dongun Yun on 2022/10/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MyViewControllerRepresentation()
                }
    }
}

struct MyViewControllerRepresentation:
    UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainViewController {
        UIStoryboard(name: "MainStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
    }

    func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
    
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
