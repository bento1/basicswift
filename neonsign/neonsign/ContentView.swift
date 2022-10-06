//
//  ContentView.swift
//  neonsign
//
//  Created by Dongun Yun on 2022/10/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MainViewControllerRepresentation()
        }
    }
}

struct MainViewControllerRepresentation:
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
