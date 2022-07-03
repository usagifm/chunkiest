//
//  OnBoardingView.swift
//  Task Management Beta
//
//  Created by Rafik Lutfi on 02/07/22.
//


import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        Onboard()
    }
}

struct Onboard: View {
     
    @State var CurrentIndex : Int = 0
    @State var ArrayOfImage : [String] = ["pic0", "pic1", "pic2"]
    @State var ArrayOfTitle : [String] = ["Welcome To Chunkist", "Take Baby Steps", "Track Progress"]
    @State var ArrayOfSubtitle : [String] = ["\"The secret of getting ahead is start where you are, with what you’ve got.\"", "\"Simplify your task by breaking it down\"", "\"Be aware on how your journeys have been\""]
     
    var body: some View {
        VStack {
             
            //Carousel Slider
            TabView(selection: $CurrentIndex) {
                ForEach(0...2,id: \.self) {index in
                     
                    //Custom Scroll Effect
                    GeometryReader{proxy -> AnyView in
                         
                        let minX = proxy.frame(in: .global).minX
                         
                        let width = UIScreen.main.bounds.width
                        let progress = -minX / (width * 2)
                         
                        var scale = progress > 0 ? 1 - progress : 1 + progress
                        let _ = print("Width \(width) minX \(minX) progress \(progress) scale \(scale)")
                        scale = scale < 0.7 ? 0.7 : scale
                         
                        return AnyView(
                            VStack{
                                Image(ArrayOfImage[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.horizontal,10)
                                    .frame(width: 200, height: 200, alignment: .center)
                                 
                                Text(ArrayOfTitle[index])
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.cyan)
                                    //.background(Color.green)
                                    .padding()
                                 
                                Text(ArrayOfSubtitle[index])
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 18, weight: .light))
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                     
                            }
                                .frame(maxWidth: width, maxHeight: .infinity, alignment: .center)
                            .scaleEffect(scale)
                        )
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
             
            //custom tab indicator
             
            CustomeTabIndicator(count: 3, current: $CurrentIndex)
                .padding(.vertical)
//                .padding(.top)
             
            VStack(spacing:15) {
                Button(action: {
                    
                    if (CurrentIndex < 2){
                    CurrentIndex = CurrentIndex + 1
                    } else {
                        
                        withAnimation {
                            UserDefaults.standard.set(true, forKey: "isStart")
                        }
                        // bikin ga bakal muncul lagi onboardinnya
                        print("index exceeded")
                        
                    }
                    
                }, label: {
                    HStack{
                         
                        Text("CONTINUE")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 250, height: 25, alignment: .center)
                    }
                    .padding(.vertical,20)
                    .padding(.horizontal)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .cyan]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(30)
                })
                
                    Button {
                        withAnimation {
                            UserDefaults.standard.set(true, forKey: "isStart")
                        }
                        // bikin ga bakal muncul lagi onboardinnya
                    } label: {
                        Text("Skip")
                            .bold()
                            .foregroundColor(.gray)
                        
                    }.opacity(CurrentIndex == 2 ? 0 : 1)
            }
            .padding(.bottom, 50)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white).ignoresSafeArea()
    }
}

struct CustomeTabIndicator: View {
     
    var count: Int
    @Binding var current: Int
     
    var body: some View {
         
        HStack {
             
            HStack {
                ForEach(0..<count,id: \.self) { index in
                     
                    ZStack {
                        //image  index start from 1..
                        if (current - 0) == index {
                            Circle()
                                .fill(Color.gray)
                        }
                        else {
                             
                            Circle()
                                .fill(Color.white)
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 1.5)
                                )
                        }
                    }
                    .frame(width: 10, height: 10)
                }
            }
        }
    }
}




struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}

