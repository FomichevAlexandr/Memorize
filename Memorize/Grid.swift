//
//  Grid.swift
//  Memorize
//
//  Created by Александр Фомичев on 30.10.2020.
//  Copyright © 2020 Fomichev Alexander. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View{
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    init(_ items: [Item],  viewForItem: @escaping (Item) -> ItemView){
        self.items = items
        self.viewForItem = viewForItem
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

