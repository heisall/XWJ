//
//  XWJUrl.h
//  XWJ
//
//  Created by Sun on 15/12/7.
//  Copyright © 2015年 Paul. All rights reserved.
//

#ifndef XWJUrl_h
#define XWJUrl_h


#define MESSAGE_CONTENT @"【信我家】您的信我家验证码为：%d，感谢您的使用！"

#define XWJBASEURL @"http://www.hisenseplus.com:8100/appPhone/rest/"
#define IDCODE_URL @"http://dx.qxtsms.cn/sms.aspx?action=send&userid=%@&account=hisenseplus&password=hisenseplus&mobile=%@&content=%@&sendTime=&checkcontent=1"

#define LOGIN_URL  XWJBASEURL"user/userLogin"
#define REGISTER_URL  XWJBASEURL"user/register"
#define RESETPWD_URL  XWJBASEURL"user/resetPass"
#define AD_URL  XWJBASEURL"index/ads"
#endif /* XWJUrl_h */
