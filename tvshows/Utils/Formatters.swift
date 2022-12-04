//
//  Formatters.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation


let airDateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "yy-MM-dd"
  return formatter
}()

let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "MMM d, y"
  return formatter
}()
