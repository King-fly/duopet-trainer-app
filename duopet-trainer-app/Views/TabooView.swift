//
//  TabooView.swift
//  duopet-trainer-app
//

import SwiftUI

struct TabooView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 22, weight: .bold))
                        Text("训练禁忌")
                            .font(.system(size: 26, weight: .black))
                    }
                    .foregroundColor(.duoRed)
                    
                    Text("这些行为会彻底毁掉你们的信任，绝对禁止！")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                
                ForEach(TabooDataProvider.taboos) { taboo in
                    HStack(alignment: .top, spacing: 14) {
                        Text("🚫")
                            .font(.system(size: 24))
                            .padding(.top, 2)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(taboo.title)
                                .font(.system(size: 12, weight: .black))
                                .tracking(1)
                                .textCase(.uppercase)
                                .foregroundColor(.duoRed)
                            
                            Text(taboo.reason)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(DuoColors.text(colorScheme).opacity(0.8))
                                .lineSpacing(3)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .duo3DBackground(
                        cornerRadius: 20,
                        fill: Color.duoRed.opacity(colorScheme == .dark ? 0.1 : 0.05),
                        border: Color.duoRed.opacity(0.3),
                        bottom: Color.duoRed.opacity(0.15),
                        bottomHeight: 3,
                        strokeWidth: 2
                    )
                    .padding(.horizontal, 20)
                }
            }
            .padding(.bottom, 24)
        }
    }
}

#Preview {
    TabooView()
}
