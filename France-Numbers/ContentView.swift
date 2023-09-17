//
//  ContentView.swift
//  France-Numbers
//
//  Created by Yuki on 2021/08/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    let dict = [
        "zero",
        "un",
        "deux",
        "trois",
        "quatre",
        "cinq",
        "six",
        "sept",
        "huit",
        "neuf",
        "dix",
        "onze",
        "douze",
        "treize",
        "quatorze",
        "quinze",
        "seize",
        "dix-sept",
        "dix-huit",
        "dix-neuf",
        "vingt",
        "vingt et un",
        "vingt-deux",
        "vingt-trois",
        "vingt-quatre",
        "vingt-cinq",
        "vingt-six",
        "vingt-sept",
        "vingt-huit",
        "vingt-neuf",
        "trente",
        "trente et un",
        "trente-deux",
        "trente-trois",
        "trente-quatre",
        "trente-cinq",
        "trente-six",
        "trente-sept",
        "trente-huit",
        "trente-neuf",
        "quarante",
        "quarante et un",
        "quarante-deux",
        "quarante-trois",
        "quarante-quatre",
        "quarante-cinq",
        "quarante-six",
        "quarante-sept",
        "quarante-huit",
        "quarante-neuf",
        "cinquante",
        "cinquante et un",
        "cinquante-deux",
        "cinquante-trois",
        "cinquante-quatre",
        "cinquante-cinq",
        "cinquante-six",
        "cinquante-sept",
        "cinquante-huit",
        "cinquante-neuf",
        "soixante",
        "soixante et un",
        "soixante-deux ",
        "soixante-trois ",
        "soixante-quatre",
        "soixante-cinq ",
        "soixante-six ",
        "soixante-sept ",
        "soixante-huit ",
        "soixante-neuf",
        "soixante-dix",
        "soixante et onze",
        "soixante-douze",
        "soixante-treize",
        "soixante-quatorze",
        "soixante-quinze",
        "soixante-seize",
        "soixante-dix-sept",
        "soixante-dix-huit",
        "soixante-dix-neuf",
        "quatre-vingts",
        "quatre-vingt-un",
        "quatre-vingt-deux",
        "quatre-vingt-trois",
        "quatre-vingt-quatre",
        "quatre-vingt-cinq",
        "quatre-vingt-six",
        "quatre-vingt-sept",
        "quatre-vingt-huit",
        "quatre-vingt-neuf",
        "quatre-vingt-dix",
        "quatre-vingt-onze",
        "quatre-vingt-douze",
        "quatre-vingt-treize",
        "quatre-vingt-quatorze",
        "quatre-vingt-quinze",
        "quatre-vingt-seize",
        "quatre-vingt-dix-sept",
        "quatre-vingt-dix-huit",
        "quatre-vingt-dix-neuf",
        "cent",
    ]
    let talker = AVSpeechSynthesizer()
    @State var MainLabel = "0"
    @State var data = 0
    @State var sheet_input = "0"
    func setNumber(num: Int) {
        talker.stopSpeaking(at: AVSpeechBoundary.immediate)
        data = num
        MainLabel = String(data)
        isNumber = true
    }
    func translate() {
        MainLabel = dict[data]
        let uttr = AVSpeechUtterance(string: MainLabel)
        uttr.voice = AVSpeechSynthesisVoice(language: "fr-FR")
        talker.speak(uttr)
        isNumber = false
    }
    @State var isNumber = true
    @State var editing = false
    var body: some View {
        VStack {
            Spacer()
            Text(MainLabel)
                .font(.largeTitle)
                .padding()
                .onTapGesture {
                    sheet_input = String(data)
                    editing = true
                    MainLabel = "Loading...."
                }
            .sheet(isPresented: $editing,
                   onDismiss: {
                        if let n = Int(sheet_input) {
                            if n <= 100 {setNumber(num:n)}
                            else {setNumber(num: data)}
                        } else {
                            setNumber(num: data)
                        }
                    }
            ) {
                VStack{
                    Text("Input a number and swipe down:")
                        .font(.headline)
                    TextField("0 to 100", text: $sheet_input)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                    Spacer()
                }
            }
            Spacer()
            Text("Tap the screen to change the number.")
                .font(.footnote)
        }
        .contentShape(Rectangle())
        .onTapGesture{
            if isNumber {
                translate()
            } else {
                setNumber(num: Int.random(in: 0...100))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
