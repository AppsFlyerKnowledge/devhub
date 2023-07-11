The IDFV testing utility app allows AppsFlyer to identify your device as a testing device by preserving your app's IDFV (Identifier For Vendor) across consecutive installations.

## Why install the IDFV testing utility app?

If you repeatedly delete and reinstall your app on a device for testing purposes, the install events will not be recorded unless you [register the device identifier as belonging to a testing device in AppsFlyer](https://support.appsflyer.com/hc/en-us/articles/207031996-Registering-test-devices-). 

However, when the identifier type is IDFV (Identifier For Vendor) and the tested app is the only app on the device associated with the vendor, the IDFV value will be replaced with a new value each time the app is deleted and reinstalled. Consequently,  AppsFlyer will not recognize the device as a testing device because the IDFV value used for device registration was replaced by a different value.

To address this, the utility app, when installed on the testing device, emulates belonging to the vendor of the tested app. As a result, the registered IDFV value remains unchanged even when the tested app is deleted and reinstalled.

## How to install the IDFV testing utility app?

To enable the utility app to emulate belonging to the same vendor as the tested app, it has to be signed with the vendor's IDFV value before it is compiled and installed on the tested device.

1. Clone [the IDFV testing utilty repository](https://github.com/AppsFlyerSDK/my-idfv-by-appsflyer.git) to your local machine.
2. Open **Xcode** and select the project in the **Project Navigator.**
3. Under **TARGETS** select the target for your app.
4. Expand the **Signing** section.
5. In **Bundle Identifier**, enter an identifier with an identical prefix to the one of the app you are testing.

   **For example,** if your tested app's Bundle Identifier is `com.MyCompany.apps.myapp`, you should change the the utility app’ Bundle Identifier (`MyIDFVByAppsflyer`)  into `com.MyCompany.apps.MyIDFVByAppsflyer`.
6. Build and install the utility app on the device. The new app receives the same IDFV as your other apps.
7. Launch the app. The IDFV number is displayed in the app. You can use the IDFV when [manually regisering the device as a testing device](https://support.appsflyer.com/hc/en-us/articles/207031996#add-a-device-manually-via-the-user-interface).