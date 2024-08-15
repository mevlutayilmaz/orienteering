# Orienteering

Bu proje, oryantiring sporu için geliştirilen bir mobil uygulamadır. Oryantiring, katılımcıların harita üzerindeki belirli kontrol noktalarını en hızlı şekilde bulmalarını gerektiren bir spordur. Uygulama, modern akıllı telefonların GPS ve QR kod okuma gibi özelliklerini kullanarak oryantiringi daha erişilebilir ve kullanıcı dostu hale getirmeyi amaçlamaktadır. Uygulama, Flutter çerçevesi kullanılarak geliştirilmiştir.

## İçindekiler

- [Oryantiring Nedir?](#oryantiring-nedir)
- [Özellikler](#özellikler)
- [Kullanılan Teknolojiler](#kullanılan-teknolojiler)
- [Kurulum](#kurulum)
- [Kullanım](#kullanım)
- [Ekran Görüntüleri](#ekran-görüntüleri)

## Oryantiring Nedir?

<img align="right" width="300" src="https://github.com/user-attachments/assets/e28fc02d-01b1-40af-97b3-2453127615ec" alt="Oryantiring Görseli">

Oryantiring, katılımcıların bir harita ve pusula yardımıyla belirlenen kontrol noktalarına en hızlı şekilde ulaşmaya çalıştıkları bir doğa sporudur. Bu spor, fiziksel ve zihinsel dayanıklılığı bir araya getirir. Oryantiringde başarı, doğru yön bulma, hızlı karar verme ve etkili bir strateji geliştirmeye bağlıdır. Farklı arazi koşullarında yapılan oryantiring, genellikle ormanlık alanlarda, parkurlarda veya şehir içindeki belirli bölgelerde gerçekleştirilebilir.


Oryantiring, sadece bir spor değil, aynı zamanda doğal ortamda yön bulma becerilerinizi test eden ve geliştiren bir etkinliktir. Hem bireysel olarak hem de takım olarak yapılabilen bu spor, her yaş grubundan insan için uygundur ve doğayla iç içe olmayı sevenler için ideal bir etkinliktir.

Oryantiring, dünyada birçok ülkede popülerdir ve çeşitli yarışmalar ve etkinlikler düzenlenir. Bu spor, hem amatör hem de profesyonel sporcular tarafından ilgi görmektedir.


## Özellikler
- **Kullanıcı Kimlik Doğrulama**: Firebase Authentication ile güvenli giriş ve kayıt.
- **Gerçek Zamanlı GPS Takibi**: Kullanıcıların gerçek dünya konumlarını takip edin ve gösterin.
- **Harita Entegrasyonu**: Kullanıcıların kontrol noktalarına ulaşmalarına yardımcı olmak için etkileşimli haritalar.
- **QR Kod Entegrasyonu**: Çeşitli kontrol noktaları için QR kodları oluşturun ve tarayın.
- **Oyun Modları**: Hem iç mekan hem de dış mekan oryantiring oyunları için destek.
- **Kullanıcı Profili**: Kullanıcılar profil bilgilerini güncelleyebilir ve fotoğraf yükleyebilir.
- **Oyun Geçmişi**: Kullanıcılar oynadıkları oyunları görebilir ve skorlarını inceleyebilir.
- **İstatistik Takibi**: Performans istatistiklerini izleyin ve zaman içindeki performansınızı karşılaştırın.
- **Skor Karşılaştırma**: Arkadaşlarınızla veya diğer oyuncularla skorlarınızı karşılaştırın.

## Kullanılan Teknolojiler
- **Flutter**: Çok platformlu mobil uygulama geliştirme çerçevesi.
- **Firebase Firestore**: Kullanıcı verilerini ve oyun bilgilerini saklamak için gerçek zamanlı veritabanı.
- **Firebase Authentication**: Kullanıcı kimlik doğrulama sistemi.
- **Firebase Storage**: Kullanıcı profil fotoğraflarını ve diğer medya dosyalarını depolamak için.
- **Google Maps API**: Harita ve konum hizmetleri için.
- **QR Kod**: Kontrol noktası işaretlerini oluşturmak ve taramak için.

## Kurulum
Projeyi yerel olarak kurmak için şu adımları izleyin:

1. **Depoyu klonlayın:**
   ```bash
   git clone https://github.com/mevlutayilmaz/orienteering.git

2. **Proje dizinine gidin:**
   ```bash
   cd orienteering-app

3. **Bağımlılıkları yükleyin:**
   ```bash
   flutter pub get

4. **Firebase'i projeniz için ayarlayın:**
    - Firebase Konsolu üzerinden bir Firebase projesi oluşturun.
    - Firebase projenize Android ve iOS uygulamaları ekleyin.
    - `google-services.json` ve `GoogleService-Info.plist` dosyalarını Firebase'den indirip proje dosyalarınızla değiştirin.

5. **Google Maps API'yi Ayarlama:**
    - Google Cloud Console'dan bir API anahtarı oluşturun.
    - Oluşturduğunuz API anahtarını aşağıdaki gibi `AndroidManifest.xml` dosyasına ekleyin:

   ```xml
     <meta-data 
      android:name="com.google.android.geo.API_KEY"
      android:value="YOUR_API_KEY"/>

   ```
    - Bu dosya, proje dizininde `android/app/src/main/AndroidManifest.xml` yolunda bulunmaktadır.

6. **Uygulamayı çalıştırın:**
   ```bash
   flutter run

## Kullanım

### 1. Giriş ve Kayıt
- **Kayıt Ol:** Yeni bir kullanıcı olarak kayıt olun. E-posta adresinizi ve şifrenizi girin. Ayrıca, isteğe bağlı olarak bir profil fotoğrafı yükleyebilirsiniz.
- **Giriş Yap:** Mevcut bir hesabınız varsa, e-posta adresiniz ve şifrenizle giriş yapın.

### 2. Kullanıcı Profili
- **Profil Güncelleme:** Profil sayfanıza gidin. Burada adınızı, e-posta adresinizi güncelleyebilir ve yeni bir profil fotoğrafı yükleyebilirsiniz.
- **Profil Fotoğrafı Yükleme:** Galerinizden bir fotoğraf seçin veya kamerayı kullanarak yeni bir fotoğraf çekin.

### 3. Oyun Oluşturma ve Oynama
- **Oyun Modları:** İç mekan ve dış mekan oryantiring oyunları arasında seçim yapabilirsiniz.
- **Oyun Oluşturma:** Yeni bir oyun oluştururken, kontrol noktalarını belirleyin ve QR kodlarını yerleştirin (iç mekan oyunlar için). Oyun başlamadan önce haritada bu noktaları işaretleyin.
- **Oynama:** Oyun sırasında, GPS'inizi kullanarak belirtilen kontrol noktalarına gidin. Kontrol noktasına ulaştığınızda, QR kodunu tarayarak (iç mekan oyunlar için) ilerleyin.
- **Gerçek Zamanlı Takip:** Harita üzerinde kendinizi ve kontrol noktalarınızı gerçek zamanlı olarak görün.

### 4. Oyun Geçmişi ve İstatistikler
- **Oyun Geçmişi:** Oynadığınız oyunların bir listesini profil sayfanızda görebilirsiniz. Her bir oyun için hangi kontrol noktalarına ulaştığınızı ve oyun süresini inceleyin.
- **Skorlar ve Karşılaştırma:** Oyun sonrasında, skorlarınızı inceleyin ve diğer oyuncularla karşılaştırın. Skorlar, harita üzerinde hangi noktalara ne kadar sürede ulaştığınızı gösterir.
- **İstatistik Takibi:** Zaman içindeki performansınızı grafiklerle inceleyin. En hızlı sürede tamamladığınız oyunları ve genel başarı oranınızı görün.

### 5. QR Kod Yönetimi
- **Kontrol Noktası Oluşturma:** Yeni bir iç mekan oyunu oluştururken, her bir kontrol noktası için bir QR kodu oluşturabilirsiniz. Bu kodlar, oyun sırasında taranmak üzere kullanılır.
- **QR Kod Tarama:** Oyun sırasında belirtilen kontrol noktasına ulaştığınızda, QR kodu tarayarak ilerleyin. Bu, oyunun ilerleyişini kaydeder ve skorlarınızı günceller.

## Ekran Görüntüleri

<table style="border-spacing: 0; border-collapse: collapse; width: 100%;">
  <tr>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/9e6c635a-9353-4ef4-8ab5-8f8c2ebfb893" width="150" />
      <p style="text-align: center; font-size: 12px;">Welcome</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/a60956f6-6765-4789-83c2-4825053aef5a" width="150" />
      <p style="text-align: center; font-size: 12px;">Login</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/8d5bbf2b-196f-484e-bc1e-a5a41de70b60" width="150" />
      <p style="text-align: center; font-size: 12px;">Signup</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/f434c71c-12ed-483d-87cf-5b7799ccbea3" width="150" />
      <p style="text-align: center; font-size: 12px;">Home</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/8cb81314-b323-4dad-8c54-4059434c316e" width="150" />
      <p style="text-align: center; font-size: 12px;">Profile</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/4b279998-3610-4f91-aff8-e9105da08053" width="150" />
      <p style="text-align: center; font-size: 12px;">Statistics</p>
    </td>
  </tr>

  <tr>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/98aed30e-95c5-4fdd-a26b-5d54c95b6d9b" width="150" />
      <p style="text-align: center; font-size: 12px;">About Orienteering</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/5c71459d-ad3b-4fac-8e96-0c2706da8f05" width="150" />
      <p style="text-align: center; font-size: 12px;">Outdoor Games</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/f02b89a7-a73d-484e-841f-e9beec0ed154" width="150" />
      <p style="text-align: center; font-size: 12px;">Indoor Games</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/928f2e3a-d222-4c8a-8058-e6e7b60c88e1" width="150" />
      <p style="text-align: center; font-size: 12px;">Edit Profile</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/60a77683-7e7a-4b73-8fea-dd2b2362b5f1" width="150" />
      <p style="text-align: center; font-size: 12px;">Create Game Home</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/ebb44206-b08f-43d5-9716-3c082c7f935c" width="150" />
      <p style="text-align: center; font-size: 12px;">Create Game Outdoor</p>
    </td>
  </tr>

  <tr>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/b43151ff-4011-4dae-b806-e086b714efc6" width="150" />
      <p style="text-align: center; font-size: 12px;">Create Game Indoor</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/292995cb-9e3c-4aac-a307-ea71724e839c" width="150" />
      <p style="text-align: center; font-size: 12px;">Create QR</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/daf4b278-5d08-4a42-b133-2e4d824594c7" width="150" />
      <p style="text-align: center; font-size: 12px;">My Games</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/f6638e79-6c0f-4417-97ad-bead5276092a" width="150" />
      <p style="text-align: center; font-size: 12px;">Light Mode</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/69330e96-d6b9-416a-b8ac-f68b059d138e" width="150" />
      <p style="text-align: center; font-size: 12px;">Dark Mode</p>
    </td>
    <td style="padding: 0; vertical-align: middle; text-align: center;">
      <img src="https://github.com/user-attachments/assets/2eaa1570-0c32-4ba9-813e-95b29e1c7c66" width="150" />
      <p style="text-align: center; font-size: 12px;">No Internet</p>
    </td>
  </tr>
</table>
