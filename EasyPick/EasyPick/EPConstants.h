//
//  EPConstants.h
//  EasyPick
//
//  Created by Mahesh Kumar on 10/12/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#ifndef EasyPick_EPConstants_h
#define EasyPick_EPConstants_h
/*
//http://dforce-hack.herokuapp.com/wrapper.php?zip=94101&date=10%20Oct,%202014&budget=500
*/
static NSString * const SHBaseURLString = @"http://dforce-hack.herokuapp.com/wrapper.php?";
static NSString * const SH_API_ZIP_REQ = @"zip";
static NSString * const SH_API_DATE_REQ = @"date";// 10 Oct, 2014
static NSString * const SH_API_BUDGET_REQ = @"budget";
static NSString * const SH_API_KEY =    @"52dabe041d18e8ef8cc324288fecf97a3f0f0b69";
static NSString * const SH_USER_NAME =    @"4085057191";
static NSString * const SH_API_REQ_FORMAT =
@"http://dforce-hack.herokuapp.com/wrapper.php?zip=%@&date=%@&budget=%@";
static NSString * const SH_API_REQ_PARAM_FORMAT =
@"%@/?username=%@&api_key=%@";

#endif
