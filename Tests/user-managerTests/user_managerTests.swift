import XCTest
@testable import user_manager

import rest_client_api
import filestore

final class user_managerTests: XCTestCase  {
    
    func testExample() async throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
        
        let url = Url(baseUrl: "https://jsonplaceholder.typicode.com", pathParams: "posts", "1")
        let request = Request(url: url)
        let client = UrlSessionRestClientAsync()
        let response = try await client.get(request: request)
        print(response.payload)
        XCTAssertEqual(response.statusCode, 200)
        XCTAssertFalse(response.payload.isEmpty)
    }
    
    func testFileManager() {
        let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)[0]
        print(dir)
        let blockManager = BlockManager(blockDirectory: dir)
        
        do {
            try blockManager.create(resourceId: "testFile")
            print("File Created.")
        } catch {
            
        }
    }
    
    func testJsonFile() {
        do {
            let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)[0]
            let manager = BlockManager(blockDirectory: dir)
//            try manager.create(resourceId: "user.json")
            let pfm = PlainFileManager(blockManager: manager)
//            try file.write()
            let file = try pfm.create(resourceId: "test");
            let jsonFile = JsonFile<User>(file: file)
            print(jsonFile)
            
            let user = User(name: "Yuvraj", email: "abc@xyz.com", phoneNumber: "7250378940")
            print(user)

            try jsonFile.write(user)

            let loadedUser = try jsonFile.read()
            print(loadedUser)
        } catch {
            print(error)
        }
    }
    
//    var sessionId : String?
//    func testSendOtp() async {
//        do {
//            let client = SignUpClient(baseUrl: "http://56.228.27.35:8080/api/v1")
//            sessionId = try await client.sendOTP(phoneNumber: PhoneNumber(countryCode: "+91", number: "9334345085"))
////            let sessionid = try await client.sendOTP(emailId: "singh.yuvraj1047@gmail.com")
//            print(sessionId!)
//        } catch let error as ExistError {
//            print(error.message)
//        } catch {
//            print(error)
//        }
//    }
    
    func testSignUp() async {
        do {
            let client = SignUpClient(baseUrl: "http://56.228.27.35:8080/api/v1")
//            let user = try await client.signUp(signUpRequest: SignUpRequest(
//                emailId : "",
//                phoneNumber: PhoneNumber(countryCode: "+91", number: "9334345085"),
//                otp: 173678, sessionId: "685f8783714d1ee94108195d", device: Device(
//                    serialNumber: "", name: "", os: "", fingerPrint: "", deviceType: DeviceType.ios
//                ), app: "SOCIAL"
//            ))
////            let sessionid = try await client.sendOTP(emailId: "singh.yuvraj1047@gmail.com")
//            print(user.apiKey)
        } catch {
            print(error)
        }
    }
}

struct User : Encodable, Decodable {
    var name : String
    var email: String
    var phoneNumber: String
}
