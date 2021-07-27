//
//  ContentView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 09/04/2021.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    static let homeViewTag: String? = "HomeView"
    
    @State private var showDiagnosticSheet = false
    @State private var showAlert = false
    @State private var showMoreInfo = false
    
    @Binding var showFlag: Bool
    @Binding var dismissFlag: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            emptyViewContent
                .navigationTitle("Accueil")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var emptyViewContent: some View {
        ScrollView(.vertical) {
            VStack {
                HStack {
                    Spacer()
                    Image("logo_sfa")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .accessibility(label: Text("SFA Logo"))
                        .onTapGesture {
                            openURL("http://www.sofarthro.com/")
                    }
                    
                    Spacer()
                    
                    Image("logo_fondation")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .accessibility(label: Text("Foundation Logo"))
                        .onTapGesture {
                            openURL("https://www.fondationpaulbennetot.org/")
                        }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                
                Image("doctor_illustration")
                    .resizable()
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 220, height: 220)
                    .padding(.bottom, 20)
                            
                Text("Appuyez sur le bouton ci-dessous pour commencer un diagnostic")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding()
                
                Button("Nouveau diagnostic") {
                    self.showDiagnosticSheet.toggle()
                }
                .buttonStyle(ColoredButtonStyle(color: .accentColor))
                .padding(.top, 15)
                
                Text("Les données ne sont jamais sauvegardées, ni sur l'appareil, ni sur un serveur. Vous pourrez envoyer le diagnostic par courriel lors du résultat.")
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .padding()
                    .padding(.top)
                
                Text("Ce test a été conçu pour des patients adultes et peut se révéler moins fiable sur des patients mineurs.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .padding()                
                
                Button(action: {
                    self.showMoreInfo.toggle()
                }) {
                    Text("Plus d'informations")
                        .font(.callout)
                }
                .padding(.top)
                
            }
            .padding(.vertical)
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text("Information"),
                    message: Text("En continuant, vous vous engagez à tenir le rôle de médecin."),
                    primaryButton: .default(Text("Continuer"), action: {
                    self.showDiagnosticSheet.toggle()
                }), secondaryButton: .cancel(Text("Annuler"))
                )
            })
            .sheet(isPresented: $showMoreInfo, content: {
                MoreInfoView(showFlag: $showMoreInfo)
            })
            .fullScreenCover(isPresented: $showDiagnosticSheet, content: {
                QuestionnaireView(showFlag: $showDiagnosticSheet)
            })
        }
    }
    
    func openURL(_ url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

