//
//  ContentView.swift
//  StatureControl
//
//  Created by 香饽饽zizizi on 2024/3/14.
//

import SwiftUI

struct ContentView: View {
    @State private var height: Int = 0

    var body: some View {
        ZStack {
            VStack {
                Text("您的身高")
                    .font(.title)
                Text("\(height) cm")
                    .font(.body)
            }

            StatureControl(height: $height)
        }
    }
}

struct StatureControl: View {
    @Binding var height: Int
    @State private var value: Int?

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .trailing) {
                ScrollView(.vertical, showsIndicators: true) {

                    Color.clear.frame(height: geo.size.height / 2 - 10)

                    LazyVStack(alignment: .trailing, spacing: 10) {
                        ForEach(0...280, id: \.self) { num in
                            let isLong = num % 10 == 0

                            Rectangle()
                                .frame(width: isLong ? 60 : 40, height: 2)
                                .overlay(alignment: .leading) {
                                    if isLong {
                                        Text("\(num)")
                                            .frame(width: 100, alignment: .trailing)
                                            .offset(x: -110)
                                    }
                                }
                        }
                    }
                    .scrollTargetLayout()

                    Color.clear.frame(height: geo.size.height / 2 - 10)
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $value, anchor: .trailing)

                RoundedRectangle(cornerRadius: 4)
                    .fill(.red)
                    .frame(width: 60, height: 4)
            }
        }
        .onAppear {
            value = height
        }
        .onChange(of: value, initial: false) { oldValue, newValue in
            height = newValue ?? 0
        }
        .sensoryFeedback(trigger: value) { oldValue, newValue in
            return SensoryFeedback.impact(weight: .light, intensity: 0.5)
        }
    }
}

#Preview {
    ContentView()
}
