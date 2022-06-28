//
//  OnBoardingView.swift
//  Task Management Beta
//
//  Created by Rafik Lutfi on 28/06/22.
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
    @State var ArrayOfTitle : [String] = ["Welcome To Chunkist", "Break Your Task Down", "Track Progress"]
    @State var ArrayOfSubtitle : [String] = ["The secret of getting ahead is getting started.", "implify your task by making it’s size manageable.", "Check your task progress"]
     
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
                                    .frame(width: 150, height: 150, alignment: .center)
                                 
                                Text(ArrayOfTitle[index])
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.cyan)
                                    //.background(Color.green)
                                    .padding()
                                 
                                Text(ArrayOfSubtitle[index])
                                    .font(.system(size: 16, weight: .bold))
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
                Button(action: {}, label: {
                    HStack{
                         
                        Text("Continue")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.vertical,13)
                    .padding(.horizontal)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .cyan]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .cyan]), startPoint: .leading, endPoint: .trailing))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.white,lineWidth: 1)
//                            )
//                    )
                })
                Button {
                    
                } label: {
                    Text("Skip")
                        .bold()
                        .foregroundColor(.gray)
                }
            }
            .padding()
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

