---
layout: page
title: "Personalization Builder and Collect API Integration"
subtitle: "Integrate Personalization Builder and Collect API"
category: analytics
date: 2018-01-10 12:00:00
order: 2
---

These methods integrate your mobile app with Personalization Builder. Your Marketing Cloud account must include a [Personalization Builder](http://help.marketingcloud.com/en/documentation/personalization_builder) deployment use these methods. Enable the analytics option in your SDK configuration file.

## Track Cart

Use to track the contents of an in-app shopping cart. For more information about this method’s general use with Personalization Builder, see Track Items in Shopping Cart (http://help.marketingcloud.com/en/documentation/collect_code/install_collect_code/track_cart/). Review this sample code for use in your mobile app.
```
NSDictionary *cartItem = [[MarketingCloudSDK sharedInstance] sfmc_cartItemDictionaryWithPrice:@(1.10) quantity:@(1) item:@"123456" uniqueId:@"uniqueId_123456"];
NSDictionary *cart = [[MarketingCloudSDK sharedInstance] sfmc_cartDictionaryWithCartItemDictionaryArray:@[cartItem]];
[[MarketingCloudSDK sharedInstance] sfmc_trackCartContents:cart];
```
```
let cartItem = MarketingCloudSDK.sharedInstance().sfmc_cartItemDictionary(withPrice: 1.10, quantity: 1, item: "123456", uniqueId: "uniqueId_123456")
let cart = MarketingCloudSDK.sharedInstance().sfmc_cartDictionary(withCartItemDictionaryArray: [cartItem])
MarketingCloudSDK.sharedInstance().sfmc_trackCartContents(cart!)
```

## Track Conversion

Use to track a purchase made through your mobile application. For more information about this method’s general use with Personalization Builder, see [Track Purchase Details](http://help.marketingcloud.com/en/documentation/collect_code/install_collect_code/track_conversion/). Review this sample code for use in your mobile app.
```
NSDictionary *cartItem = [[MarketingCloudSDK sharedInstance] sfmc_cartItemDictionaryWithPrice:@(1.10) quantity:@(1) item:@"123456" uniqueId:@"uniqueId_123456"];
NSDictionary *cart = [[MarketingCloudSDK sharedInstance] sfmc_cartDictionaryWithCartItemDictionaryArray:@[cartItem]];
NSDictionary *order = [[MarketingCloudSDK sharedInstance] sfmc_orderDictionaryWithOrderNumber:@"123456" shipping:@(2.11) discount:@(4.99) cart:cart];
[[MarketingCloudSDK sharedInstance] sfmc_trackCartConversion:order];
```
```
        let cartItem = MarketingCloudSDK.sharedInstance().sfmc_cartItemDictionary(withPrice: 1.10, quantity: 1, item: "123456", uniqueId: "uniqueId_123456")
        let cart = MarketingCloudSDK.sharedInstance().sfmc_cartDictionary(withCartItemDictionaryArray: [cartItem])
        let order = MarketingCloudSDK.sharedInstance().sfmc_orderDictionary(withOrderNumber: "123456", shipping: 2.11, discount: 4.99, cart: cart!)
        MarketingCloudSDK.sharedInstance().sfmc_trackCartConversion(order!)
```

## Track Page View

Call this method to implement page view analytics in your app. For more information about this method’s general use with Personalization Builder, see [Track Items Viewed](http://help.marketingcloud.com/en/documentation/collect_code/install_collect_code/track_page_view/). Sample code for use in your mobile app is below.
```
[[MarketingCloudSDK sharedInstance] sfmc_trackPageViewWithURL:@"http://my.company.com" title:@"page title" item:@"item name" search:@"search term"];
```
```
MarketingCloudSDK.sharedInstance().sfmc_trackPageView(withURL: "http://my.company.com", title: "page title", item: "item name", search: "search term")
```
See MarketingCloudSDK+Intelligence.h for more information.
