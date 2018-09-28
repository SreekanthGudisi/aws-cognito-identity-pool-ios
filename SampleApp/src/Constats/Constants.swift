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

//let AWSCognitoUserPoolsSignInProviderKey = "UserPool"


let CognitoIdentityPoolIdLex = "us-east-1:c5c99941-47e3-4ec7-8a69-b0c886680dc6"     // Put your Cognito Identity Pool ID here
let CognitoRegionLex = AWSRegionType.USEast1                   // Put your Cognito region here
let LexRegionLex = AWSRegionType.USEast1                       // Change this is this is not your Lex region (most are currently AWSRegionType.USEast1)
let BotNameLex = "LamboBot"                                     // Put your bot name here
let BotAliasLex = "$LATEST"
