//
// Copyright 2014-2018 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Amazon Software License (the "License").
// You may not use this file except in compliance with the
// License. A copy of the License is located at
//
//     http://aws.amazon.com/asl/
//
// or in the "license" file accompanying this file. This file is
// distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, express or implied. See the License
// for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import AWSCognitoIdentityProvider

//// MARK :- SignIn And SignUp Intrgration
//let CognitoIdentityUserPoolRegion: AWSRegionType = .APSouth1
//let CognitoIdentityUserPoolId = "ap-south-1_R17tMtrIF"
//let CognitoIdentityUserPoolAppClientId = "7gad3k2nu7jcic8i5t2ks0hnl9"
//let CognitoIdentityUserPoolAppClientSecret = "1r2k566atl9ba4vn81ovotsneim1rdm9vsq8dn0q7lqvdhooej5u"
//
//let AWSCognitoUserPoolsSignInProviderKey = "UserPool"
//

// MARK :- LEX Intrgration
//let CognitoIdentityPoolIdLex = "ap-south-1:6a54d2ac-1278-4db1-b238-70568f698dd8"     // Put your Cognito Identity Pool ID here
//let CognitoRegionLex = AWSRegionType.APSouth1                   // Put your Cognito region here
//let LexRegionLex = AWSRegionType.USEast1                       // Change this is this is not your Lex region (most are currently AWSRegionType.USEast1)
//let BotNameLex = "LamboBot"                                     // Put your bot name here
//let BotAliasLex = "$LATEST"

let CognitoIdentityPoolIdLex = "us-east-1:c5c99941-47e3-4ec7-8a69-b0c886680dc6"     // Put your Cognito Identity Pool ID here
let CognitoRegionLex = AWSRegionType.USEast1                   // Put your Cognito region here
let LexRegionLex = AWSRegionType.USEast1                       // Change this is this is not your Lex region (most are currently AWSRegionType.USEast1)
let BotNameLex = "LamboBot"                                     // Put your bot name here
let BotAliasLex = "$LATEST"
