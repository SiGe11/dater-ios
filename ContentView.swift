//
//  ContentView.swift
//  dater
//
//  Created by Simon Gergely on 2022. 01. 10..
//

import SwiftUI

var timer = Timer()
let endSec = NSDate(dateString: "2022-04-03").timeIntervalSince1970


struct ContentView: View {
    @State var dateToDisplay: String = getTimeDiff()
    var body: some View {
        
        Color(red: 14/255, green: 56/255, blue: 122/255)
            .ignoresSafeArea()
            .overlay(
                
                VStack(spacing: 20) {
                    
                    Text(dateToDisplay)
                        .onAppear{ self.refreshTime() }
                        .foregroundColor(Color(red: 159/255, green: 175/255, blue: 202/255))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                        .font(Font.headline.weight(.bold))
                        .padding()
                    Spacer()
                }.padding()
            )
    }
    
    
    func refreshTime() {
        self.dateToDisplay = getTimeDiff()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.dateToDisplay = getTimeDiff()
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView();
    }
}


func getTimeDiff() -> String {
    let currentSec = NSDate().timeIntervalSince1970
    var diff = round(endSec - currentSec)
    
    let d = floor(diff / (24 * 60 * 60));
    diff = diff - (d * 24 * 60 * 60);
    let h = floor(diff / (60 * 60));
    diff = diff - (h * 60 * 60);
    let m = floor(diff / (60));
    diff = diff - (m * 60);
    let s = diff;
    
    
    return "\(Int(d)) nap, \(Int(h)) óra, \(Int(m)) perc, \(Int(s)) másodperc"
}

extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = Locale(identifier: "hu")
        let d = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:d)
    }
}


