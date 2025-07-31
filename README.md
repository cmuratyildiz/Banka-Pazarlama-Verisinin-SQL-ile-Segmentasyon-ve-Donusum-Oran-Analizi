# Banka-Pazarlama-Verisinin-SQL-ile-Segmentasyon-ve-D-n-m-Oran-Analizi

Ortalama müşteri yaşı kaçtır?

En çok görülen meslekler nelerdir?

Müşterilerin medeni durum dağılımı nasıldır?

Eğitim seviyelerine göre müşteri sayısı dağılımı nedir?

Kredi temerrüt (default) oranı nedir?

Ortalama bakiye (balance) kaç Euro’dur?
----------------------------------------------------------------------

Konut kredisi olan müşterilerin yüzdesi nedir?

Hem konut hem de kişisel kredisi olan müşteri sayısı kaçtır?

“default” geçmişi olan müşterilerden kaçı hâlâ kredi kullanıyor?

Meslek gruplarına göre kredi kullanma eğilimi nasıldır?
----------------------------------------------------------------------
Kampanya kapsamında en çok hangi iletişim türü (cellular, telephone) kullanılmıştır?

Hangi ayda en çok müşteriye ulaşılmış?

Ortalama kampanya süresi (duration) nedir?

“poutcome” değeri “success” olan kampanyaların sayısı kaçtır?

“pdays” değeri -1 olan kaç müşteri vardır? (Daha önce hiç ulaşılmamış)
-----------------------------------------------------------------------
Term deposit’e abone olanların oranı nedir?

Yaş aralıklarına göre abone olan müşteri oranı nasıldır?

Hangi meslek grubunda abone olma oranı daha yüksektir?

Daha önceki kampanyalarda başarı sağlayan müşteriler yeniden abone olmuş mu?

Eğitim durumuna göre abone olma eğilimi nasıldır?
----------------------------------------------------------------------

Arama Sayısı - Abonelik Oranı İlişkisi
Müşteri kampanya boyunca kaç kez arandı? Bu sayı arttıkça abonelik oranı yükseliyor mu?
🔍 campaign değişkeni üzerinden analiz yaptım.

İletişim Kanalının Etkisi
Telefonla mı aramak etkili, e-mail mi?
📞 contact sütununu kullanarak hangi kanalın daha yüksek dönüşüm sağladığını gösterdim.

Finansal Durum & Abonelik İlişkisi
Konut kredisi ya da kişisel kredisi olan müşteriler daha mı az ilgi gösteriyor?
🏦 housing ve loan bilgileriyle çapraz analiz gerçekleştirdim.

Yaş + Meslek + Eğitim Kombinasyonlarıyla Tahminleme
Hangi müşteri segmenti daha çok dönüş sağlıyor?
🎯 Yaş grubu, meslek ve eğitim düzeyi birleşimiyle hedef grupları belirledim.
