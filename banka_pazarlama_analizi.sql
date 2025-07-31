/*Ortalama müşteri yaşı kaçtır?*/
SELECT ROUND(AVG(age)) as Ortalama_Müşteri_Yaşı FROM `banka`


/*En çok görülen meslekler nelerdir?*/

SELECT
    job,
    COUNT(job) AS Müşteri_Meslek_Dağılımı
FROM
    banka
GROUP BY
    job
ORDER BY
    Müşteri_Meslek_Dağılımı
DESC


/*Müşterilerin medeni durum dağılımı nasıldır?*/

SELECT
    marital,
    COUNT(marital) AS Müşteri_MedeniHali_Dağılımı
FROM
    banka
GROUP BY
    marital
ORDER BY
    Müşteri_MedeniHali_Dağılımı
DESC

/*Eğitim seviyelerine göre müşteri sayısı dağılımı nedir?*/

SELECT
    education,
    COUNT(education) AS Müşteri_Eğitim_Dağılımı
FROM
    banka
GROUP BY
    education
ORDER BY
    Müşteri_Eğitim_Dağılımı
DESC

/*Kredi temerrüt oranı nedir?*/

	SELECT
    ROUND(
        SUM(
            CASE WHEN `default` = 'yes' THEN 1 ELSE 0
        END
    ) / COUNT(*) * 100,
    2
) AS temerrut_orani_yuzde
FROM
    banka;
    
 /*Ortalama bakiye (balance) kaç Euro’dur?*/

SELECT 
  ROUND(AVG(balance), 2) AS ortalama_bakiye_euro
FROM banka;

/*Konut kredisi olan müşterilerin yüzdesi nedir?*/

SELECT 
  ROUND(
    (SUM(CASE WHEN housing = 'yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 
    2
  ) AS konut_kredisi_yuzdesi
FROM banka;

/*Hem konut hem de kişisel kredisi olan müşteri sayısı kaçtır?*/

SELECT COUNT(*) AS kredi_sahibi_musteri_sayisi
FROM banka
WHERE housing = 'yes' AND loan = 'yes';


/*'default' geçmişi olan müşterilerden kaçı hâlâ kredi kullanıyor?*/

SELECT
    COUNT(*) AS aktif_kredi_kullanan_default_musteri
FROM
    banka
WHERE
    `default` = 'yes' AND(housing = 'yes' OR loan = 'yes');


/*Meslek gruplarına göre kredi kullanma eğilimi nasıldır?*/

SELECT
    job,
    COUNT(*) AS toplam_musteri,
    SUM(housing = 'yes') AS konut_kredisi_kullanan,
    ROUND(
        SUM(housing = 'yes') / COUNT(*) * 100,
        2
    ) AS konut_kredi_orani,
    SUM(loan = 'yes') AS kisisel_kredisi_kullanan,
    ROUND(
        SUM(loan = 'yes') / COUNT(*) * 100,
        2
    ) AS kisisel_kredi_orani
FROM
    banka
GROUP BY
    job
ORDER BY
    toplam_musteri
DESC
    ;


/* Kampanya kapsamında en çok hangi iletişim türü (cellular, telephone) kullanılmıştır?*/

SELECT
    contact AS iletisim_turu,
    COUNT(*) AS toplam_kullanim
FROM
    banka
GROUP BY
    contact
ORDER BY
    toplam_kullanim
DESC
LIMIT 1;


/*Hangi ayda en çok müşteriye ulaşılmış?*/

SELECT
    month,
    COUNT(*) AS musteri_sayisi
FROM
    banka
GROUP BY
    MONTH
ORDER BY
    musteri_sayisi
DESC
LIMIT 1;


/* Ortalama kampanya süresi (duration) nedir?*/

SELECT 
    AVG(duration) AS ortalama_kampanya_suresi
FROM banka;


/* “poutcome” değeri “success” olan kampanyaların sayısı kaçtır?*/

SELECT
    COUNT(*) AS success_kampanya_sayisi
FROM
    banka
WHERE
    poutcome = 'success';

/*“pdays” değeri -1 olan kaç müşteri vardır? (Daha önce hiç ulaşılmamış)*/

SELECT 
    COUNT(*) AS hic_ulasilmamis_musteri_sayisi
FROM 
    banka
WHERE 
    pdays = -1;

/* Term deposit’e abone olanların oranı nedir?*/

SELECT
    ROUND(
        SUM(
            CASE WHEN Y = 'yes' THEN 1 ELSE 0
        END
    ) / COUNT(*) * 100,
    2
) AS üye_oranı
FROM
    banka

/* Yaş aralıklarına göre abone olan müşteri oranı nasıldır?*/

SELECT CASE WHEN
    age < 20 THEN '0-19' WHEN age BETWEEN 20 AND 29 THEN '20-29' WHEN age BETWEEN 30 AND 39 THEN '30-39' WHEN age BETWEEN 40 AND 49 THEN '40-49' WHEN age BETWEEN 50 AND 59 THEN '50-59' WHEN age >= 60 THEN '60+' ELSE 'Bilinmiyor'
END AS yas_araligi,
COUNT(*) AS toplam_musteri,
SUM(
    CASE WHEN Y = 'yes' THEN 1 ELSE 0
END
) AS abone_sayisi,
ROUND(
    SUM(
        CASE WHEN Y = 'yes' THEN 1 ELSE 0
    END
) / COUNT(*) * 100,
2
) AS abone_orani_yuzde
FROM
    banka
GROUP BY
    yas_araligi
ORDER BY
    yas_araligi;


/*Hangi meslek grubunda abone olma oranı daha yüksektir?*/

SELECT
    job AS meslek,
    COUNT(*) AS toplam_musteri,
    SUM(
        CASE WHEN Y = 'yes' THEN 1 ELSE 0
    END
) AS abone_sayisi,
ROUND(
    SUM(
        CASE WHEN Y = 'yes' THEN 1 ELSE 0
    END
) / COUNT(*) * 100,
2
) AS abone_orani_yuzde
FROM
    banka
GROUP BY
    job
ORDER BY
    abone_orani_yuzde
DESC
    ;

/* Daha önceki kampanyalarda başarı sağlayan müşteriler yeniden abone olmuş mu?*/

SELECT 
  poutcome AS onceki_kampanya_sonucu,
  COUNT(*) AS toplam_kisi,
  SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS yeniden_abone_olan,
  ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS abone_orani_yuzde
FROM banka
WHERE poutcome IN ('success', 'failure')
GROUP BY poutcome
ORDER BY abone_orani_yuzde DESC;

/* Eğitim durumuna göre abone olma eğilimi nasıldır?*/

SELECT
    education AS egitim_durumu,
    COUNT(*) AS toplam_kisi,
    SUM(
        CASE WHEN Y = 'yes' THEN 1 ELSE 0
    END
) AS abone_olan,
ROUND(
    SUM(
        CASE WHEN Y = 'yes' THEN 1 ELSE 0
    END
) / COUNT(*) * 100,
2
) AS abone_orani_yuzde
FROM
    banka
GROUP BY
    education
ORDER BY
    abone_orani_yuzde
DESC
    ;
    
 /*Kampanyada daha fazla kez aranan müşterilerin abone olma oranı daha mı yüksek?   */
    SELECT
    campaign AS arama_sayisi,
    COUNT(*) AS toplam_kisi,
    SUM(
        CASE WHEN Y = 'yes' THEN 1 ELSE 0
    END
) AS abone_olan,
ROUND(
    100 * SUM(
        CASE WHEN Y = 'yes' THEN 1 ELSE 0
    END
) / COUNT(*),
2
) AS abone_orani
FROM
    banka
GROUP BY
    campaign
ORDER BY
    campaign;
    
    /*Hangi iletişim türü ile abone oranı daha yüksek?*/
    
    SELECT
    contact AS iletisim_tipi,
    COUNT(*) AS toplam_kisi,
    SUM(
        CASE WHEN Y = 'yes' THEN 1 ELSE 0
    END
) AS abone_olan,
ROUND(
    100 * SUM(
        CASE WHEN Y = 'yes' THEN 1 ELSE 0
    END
) / COUNT(*),
2
) AS abone_orani
FROM
    banka
GROUP BY
    contact
ORDER BY
    abone_orani
DESC
    ;
    
    /*Ev kredisi ve ihtiyaç kredisi bilgisi olan müşterilerin abone olma olasılığı?*/
    
    SELECT
    housing,
    loan,
    COUNT(*) AS toplam_kisi,
    SUM(
        CASE WHEN Y = 'yes' THEN 1 ELSE 0
    END
) AS abone_olan,
ROUND(
    100 * SUM(
        CASE WHEN Y = 'yes' THEN 1 ELSE 0
    END
) / COUNT(*),
2
) AS abone_orani
FROM
    banka
GROUP BY
    housing,
    loan
ORDER BY
    abone_orani
DESC
    ;
    
    /*Yaş + meslek + eğitim kombinasyonuna göre abone tahmini için özet tablo*/
    
    SELECT
    job,
    education,
    CASE WHEN age < 30 THEN 'young' WHEN age BETWEEN 30 AND 60 THEN 'adult' ELSE 'senior'
END AS yas_grubu,
COUNT(*) AS toplam_kisi,
SUM(
    CASE WHEN Y = 'yes' THEN 1 ELSE 0
END
) AS abone_olan,
ROUND(
    100 * SUM(
        CASE WHEN Y = 'yes' THEN 1 ELSE 0
    END
) / COUNT(*),
2
) AS abone_orani
FROM
    banka
GROUP BY
    job,
    education,
    yas_grubu
ORDER BY
    abone_orani
DESC
    ;