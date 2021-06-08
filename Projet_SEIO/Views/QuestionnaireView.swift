//
//  QuestionnaireView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 04/06/2021.
//

import SwiftUI

struct QuestionnaireView: View {
    @Binding var showFlag: Bool
    @State private var scores: [Int] = []
    @State private var quizEnded = false
    @State private var questionNumber = 0
    @State private var progress = 0.1 // a changer
    @State private var allQuestions = Question.allQuestions.count
    @State private var showAlert = false
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical) {
                ZStack {
                    
                    VStack {
                        VStack {
                            VStack(spacing: 20) {
                                HStack(alignment: .center) {
                                    Text("Diagnostic")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        self.showFlag.toggle()
                                    }) {
                                        Image(systemName: "xmark")
                                            .imageScale(.large)
                                            .font(Font.headline.weight(.bold))
                                    }
                                }
                                
                                .padding(.top, proxy.safeAreaInsets.top)
                                
                                VStack {
                                    // x sur n
                                    HStack {
                                        Text("2 sur 6")
                                            .font(.system(.subheadline, design: .rounded))
                                        Spacer()
                                    }
                                    
                                    ProgressView("", value: progress, total: 1)
                                        .foregroundColor(.white)
                                        .accentColor(.white)
                                        .padding(.bottom)
                                    
                                }.padding(.top)
                                
                            }
                            .foregroundColor(.white)
                            .padding()
                            
                            
                        }
                        .padding(.bottom, 20)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 161/255, blue: 1), Color.accentColor]), startPoint: .init(x: 0, y: 0.5), endPoint: .init(x: 1, y: 0)).edgesIgnoringSafeArea([.top, .bottom]))
                        
                        
                        VStack(spacing: 0) {
                            Spacer()
                            
                            ZStack(alignment: .top) {
                                Rectangle()
                                    .frame(width: proxy.size.width)
                                    .foregroundColor(Color("BackgroundSystem"))
                                
                                EnonceView()
                                    .padding(.horizontal)
                                    .padding(.bottom)
                            }
                            
                            Spacer()
                            
                            
                            Button("← Précédent") {
                                print("Précédent tapped")
                            }
//                            .edgesIgnoringSafeArea(.bottom)
//                            .buttonStyle(BottomButtonStyle(width: proxy.size.width, height: proxy.safeAreaInsets.bottom))
//                            .shadow(radius: 15.0)
                            
                            
                        }.edgesIgnoringSafeArea(.bottom)
                    }
                    
                   
                }
                .frame(minHeight: proxy.size.height)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}


struct EnonceView: View {
    @State var selected = false
    @State var selectedIndex = -1
    var body: some View {
        VStack(spacing: 12) {
            
            Text(Question.allQuestions[4].intitule)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.top)
            
            Text("Un titre assez long ici.")
            
            Group {
                ForEach(0..<Question.allQuestions[4].choix.count, id: \.self) { i in
                    Button(action: {
                        self.selectedIndex = i
                    }) {
                        QuizReponse(title: Question.allQuestions[4].choix[i], selected: .constant(selectedIndex == i))
                            .padding(.bottom, i == (Question.allQuestions[4].choix.count - 1) ? 10 : 0)
                            .background(selectedIndex == i ? Color.blue : Color("BackgroundPlain"))
                    }
                }
            }
            
        }
       // .padding()
        .background(Color("BackgroundPlain"))
        .cornerRadius(8)
        .shadow(radius: 10.0)
    }
}

struct QuizReponse: View {
    var title: String
    @Binding var selected: Bool
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            
            Image(systemName: "chevron.forward")
        }
        .padding([.horizontal])
        .padding(.vertical, 6)
        
        .foregroundColor(selected ? .white : Color("BackgroundPlainInverted"))
    }
}
