//
//  Key.swift
//  MotherWeatherNewsIos
//
//  Created by kawaguchi kohei on 2018/08/23.
//  Copyright © 2018年 kawaguchi kohei. All rights reserved.
//

import Foundation

enum WeatherType: Int {
    case sunny
    case cloudy
    case rainy
    case thunder

    static var allcases: [WeatherType] {
        return [.sunny, cloudy, .rainy, .thunder]
    }
}
