//
//  GiftListRowView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 11.12.22.
//

import SwiftUI

struct GiftListRowView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    @ObservedObject var gift: Gift
    
    @State var isCollapsed: Bool = false
    
    @State var selectedStatus: giftStatus = giftStatusArray[0]
    
    
    
    var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 5) {
                GiftStatusMenu()
                Image(systemName: gift.unwrappedStatus)
                    .foregroundColor(.yellow)
                Text(gift.unwrappedTitle)
                Spacer()
                Text(String(gift.unwrappedPrice))
            }
            .onAppear {
                for status in giftStatusArray {
                    if (status.title == gift.status) {
                        selectedStatus = status
                    }
                }
            }
        }
    }
    fileprivate func GiftStatusMenu() -> Menu<some View, ForEach<[giftStatus], UUID, Button<Label<Text, Image>>>> {
        return Menu {
            ForEach(giftStatusArray) { status in
                Button {
                    selectedStatus = status
                    gift.status = selectedStatus.title
                    
                    do { try self.managedObjectContext.save() }
                    catch { print(error) }
                    
                } label: {
                    Label(status.title, systemImage: status.icon)
                }
            }
        } label: {
            Image(systemName: selectedStatus.icon)
                .foregroundColor(selectedStatus.Color)
        }
        
    }
}

