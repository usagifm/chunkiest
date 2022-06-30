//
//  StatisticView.swift
//  Task Management Beta
//
//  Created by Muhammad Nur Faqqih on 01/07/22.
//

import SwiftUI

struct StatisticView: View {
    var body: some View {
     
            
            VStack(){
                
                HStack{
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            Text("Left")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .frame(width: geometry.size.width * 0.5)
                                .background(.yellow)
                            Text("Right")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .frame(width: geometry.size.width * 0.5)
                                .background(.orange)
                        }
                    }
                    
                    
                    
                }.frame(height: 2)
                .padding()
                
                
                
                HStack{
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            Text("Left")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .frame(width: geometry.size.width * 0.5)
                                .background(.yellow)
                            Text("Right")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .frame(width: geometry.size.width * 0.5)
                                .background(.orange)
                        }
                    }
                    
                    
                    
                }.frame(height: 50)
                .padding()
                
            }.frame(maxHeight: .infinity, alignment: .bottom)
            
            
            
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
    }
}
