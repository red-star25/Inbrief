# Inbreif - A News App 🔥🔥🔥🔥🔥

![](https://lh3.googleusercontent.com/C3DP7J5qVfczPRWK0FGR-6laEWpnU58rp1fAIUQs1MJ1GQ6qk2yv-E0NaLJ-mFbw7w)

### Inbrief Provides the most trending and usefule news from all around the world.


### Information about the app:

```
InBrief is a news app that selects latest and best news from multiple national
and international sources and summarizes them to present in a short and crisp format, 
personalized for you English. All summarized stories contain only headlines and facts, 
no opinions, to help you stay informed of the current affairs. we get covered and delivered 
super fast! Get updated with the latest news and current affairs in a jiffy!
```

## Screenshot 📱
![](https://lh3.googleusercontent.com/OD-gwXQC5_qN9brs8iBpSHVewfC-FOBrb0nHTvYyBXMo-X9TyLSzISNrc4ay_Gzfnw=w200-h400)
![](https://lh3.googleusercontent.com/s61bWWfCVoxGcHtt8w2dWpF__qrKlb2fFuhHqy_vJ3BWunUfhF9DDav3lmSxEHhRTQ=w200-h400)
![](https://lh3.googleusercontent.com/vBfL6-2nJqu-R3RWxjmAnFfySZ4Lkh0Q9dvPfYbxSVAEek2FKtL_mlQ1dA7eW297ew=w200-h400)
![](https://lh3.googleusercontent.com/4ty98-hdSy6hxYLtchLHX1VsVC1t_ZwR1OiwxJwBBMPC4Ln7GjA4Yg6AgyP6P9IvRpGt=w200-h400)
![](https://lh3.googleusercontent.com/bwrfSA2Nc-ffJ029D-ob5Qp9d826GsocvpulESzBqOIQ9igZ9B8L3TCpYfwocGXzqSA=w200-h400)

### Show some ❤️ and star the repo to support the project
![](https://github-images.s3.amazonaws.com/help/bootcamp/Bootcamp-Fork.png)

# Building the project 📽

Missing Key.Properties file ❌❌

If you try to build the project straight away, you'll get an error complaining that a key.properties file is missing and Exit 🚪

You have to create your own key and run it (You can follow following steps😉).

1. Open \android\app\build.gradle file and paste following lines without comments.
```
//keystoreProperties.load(new FileInputStream(keystorePropertiesFile))

signingConfigs {
// release {
// keyAlias keystoreProperties['keyAlias']
// keyPassword keystoreProperties['keyPassword']
// storeFile file(keystoreProperties['storeFile'])
// storePassword keystoreProperties['storePassword']
// }
}
buildTypes {
// release {
// signingConfig signingConfigs.release
// }
}
```

2.Open \android\local.properties and add -
```
flutter.versionName=1.0.0
flutter.versionCode=1
flutter.buildMode=release
```


Or you can follow from the Official Doc.https://flutter.dev/docs/deployment/android.


<p>
<a href="https://play.google.com/store/apps/details?id=com.NakumsDtech.inbreif"><img src="https://lh3.googleusercontent.com/e0Q-zviOOe362MO6Zf4hhbfrCy0xDnVKjc6KocBunPwYKRksIrg_H0Jl00f2oZa_uQ=s360" alt="InBrief"></a>
</p>

❤ Found this project useful?
If you found this project useful, then please consider giving it a ⭐ on Github and sharing it with your friends via social media.

### LinkedIn Profile
<p>
<a href="https://www.linkedin.com/in/dhruv-nakum-4b1054176/"><img src="https://img.icons8.com/ios-filled/2x/linkedin.png" alt="LinkedIn"></a>
</p>
