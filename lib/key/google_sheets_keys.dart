const formApiKey = r'''
  {
  "type": "service_account",
  "project_id": "topincity-374315",
  "private_key_id": "349589972e522731806624e8a5afc3edd542f669",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQCwt2L08gC7E7KF\nLzuoOMoUzlRBrbRT8nLPMj2nXXGcohPmdRECUi4od54qAf+MSlzhveUj1Zkzq+C2\nZnbJKz3QzgIteHYMHNOKGbpg64ATTkBXzLKmQMZGWDlGlSjsnprJwq2tln28O09R\nrx0jKoYebYvjiAXmmulyntq21j1IRgKX7k7JJzqXRtPZMahh3ZV7cu7GpkoTUTcP\nAq5d203rh4d6X7AcC5dVPPEMQlQWxm596gaHGAezI0XdkAXqIrUXeCf1ortDj+5U\nvo56z3skDuTXxUBiPdqSQjOCLf4DFcrz6UTjvd9fR34mdZ+2CdbbIZ4cn1DfHcBZ\nH9jH5p/rAgMBAAECgf9jBGg7k+8KBblk2I2XSAp6bbMHI8jHqyLeo/OMGeWHujrD\nRQCcMcIkEULshZxgMhWHFYbAmYbWaqsIhD91DqFrW9LmM6BlZ96FgKsNgaipwyx1\n3yvG/B8OmLKg77kZKbJOA/U03VDQisuqoALJSbX056Hw1K6gY+3oMRWV/I1jpfbk\np13a9As8HybDG5P+FY0hf4UH5uyGzNc/4ySOcZ109Bu0zB7zi0I028AQKRF/q5qG\nH5q5c+aMsCxyCJGeg3+4Av6ZLeJDQal67m/dg7kCVu5E4sIwkMrtzAOu6W+3Ad3t\nXt0qJuPQNBoPPjvELNk9U5vn1kDld4O1JuXBPeECgYEA2l0yFlRNgQMctH0b4Oc9\nr4jKbUhoB38K1rjEEviFm+hVmcoWztvwP+e7jiT5L7xSlf1zmGaTNcjZGKHdiSdU\nGQRcHaD8PKFzARgw0ZE50nH3tkSKwkxehAKYAxOtQiM/tjX8diLHIxOPEuUdySWF\njl5i24mr3anwv0kwyWV+CcsCgYEAzyyVZzZWeobauOF9eXtC0JpDIja5/Q3BQCQN\nP8VM1honz7h3qET263IUAlFDUU8mbwthRflShmHbLdHYtu2gc7CUcfciDmuMO5v3\n1pj05d8EalphBAmCIO4CLWLMYs026eieo0T3yHafIWUpc9Fu5c8Mrjmg4sEqc9zK\nVlCZfmECgYEAoeeXy5aWIKH+FpTspsTNp+j0rjKRb31yu+Ii/y3lYsPRNEXyw02v\nxLI9Dhe76vjnAu75VnY3kBlrXigl6huO7z2cTxud6haK/rTA/aGADdkSocIQYB/f\ntGF39FASlocsJh3BIpaGsCtAWfInM4zuibDR+5UIKUJnjmzmD22BFiECgYBrMHIM\neLy9oFBCH8i/tdqX+3iIlzAbkaZO/VgtinN6wwWeH58pXKU0pE1d9ZWS2BTWl1i4\nz4q3JKI2TsCFxOSjdtUXMfpY46Qmo0fTrEfpNz4dmK1hXVoKl5pgySFebTbgRw7t\nAp4BBf7HVIPh/JYYKMwyyHZJXBAO6kl15zXDgQKBgCqLKjigcv1kt/uE1YnLBuKN\nrcq50lInkJWKrRes7SMqCU+6v2rcKFYf2XrMl/GHL/0w48yU7mArMOhzN4nuTwVd\nGa9z0QTLKNNviyVZQXviAEvS1rX6Rq9NYqFTczJV4C1V3nIJ+OQVEcTc7+FBS3YM\nfxca+88JRQ5/eDGqR2gR\n-----END PRIVATE KEY-----\n",
  "client_email": "top-in-city@topincity-374315.iam.gserviceaccount.com",
  "client_id": "109199339792046955602",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/top-in-city%40topincity-374315.iam.gserviceaccount.com"
}
  ''';

const menuApiKey = r'''
{
  "type": "service_account",
  "project_id": "topincity-374315",
  "private_key_id": "e688d3ec79c15a847fd1f2f6eaf2da3396fc37ec",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCPseEreSSSbWrB\n+WtJjDMdPpDnAdUxva1dgeuipakhvvtsmvKuVbZx6JHSJcACp4+tOQewvmTAJ+5h\nNPoEfxjEzEUNgl4smBM5ghvPhhWNIujshG0T+FrwJNtS1dWqYHce1W4E7lYAk3sU\n0J/somxqCMMPfpmFUpI+ed4fGaVtGtSMrrrv66z64NW5DTgsNaZyU1gwsNOXCiNk\nRNlyHvWAq14W29DjA7HgMOF49VfEPp+tfnvWKSwqoueg5Qx9hMdiIDpCwmivkkAU\npssq+z2wZz/DJ6SHaECEFeNZW8iG2WMIs/jrbfVrcXHwKCv8nUe0hGQgnJTVi176\noquPm2X/AgMBAAECggEAKmETYC9v1lG34TKO7lePgaoAsWjMeEmRNllJZiRGkAHU\nBDFkrn7v+oNVcm2Yxg+mI7gEqR9V9ogwWXH25NmZM/1sxjGzVaKaVOUnD5rjg0cO\n/CaIRxIBu/6awsD3LbManrjipEioi63zaG2pJPC4WcNwyAKWA4iZQhzOIkz9iYIl\nl4P4+GQ+J55ETn8GdmWRKAzUIROCYS+K76kgFJWvaQY+QK7SU4BSVLy3RMonV8Je\nKiA8cdHvz3HhmdzHl2M9T5FgxQ7qu/MTYPzUJJZ01xIku4ehBL3706gDC6HgOuN5\nFZqaUS9aHnSPmz9aHKz9BARcrVNRnD9H4FmhzpB7UQKBgQDBkmVsdZ/eZS/8ub9p\n42RBM8CRlc8p3xJE3ytfYh1xEVlJi761V0I3Cmj1hieE57fUS3h9NxaPSBwrubaY\npbgRhub7X2kpxbues3wrBd9Ifzmrg0uVDPDzj7AjidDPKyKBHq8Uj22z3HPB4++s\nslbcRS6K0v/TJP1vyeAG6NuuLwKBgQC+CY5/O7SckWg9wmg1qrqbd3Wg5FrF4zMv\nF1+BQhtpJ5XZg0dKtLufC5fvoxQf7vXaKf/rxgAbt7QkjzLUm0D4OmCp/Ekwdxon\ncraFWG5anOrNTicICVzqkIxBaitGwAboQeASpVCTEaW/rdOKm3vLEXBQ1zRxOH4l\nILN2cdUhMQKBgGB3KHxIkgcuvh9gIfgPDiNAOzNSSQ9Az8XqwZ6jMrDqSGjSb5PH\njIQJeA0DciZVo9L0WXNtRJza/s77mfewfm6dn/adsbbTh5CrObHnF0L1xDOpFr2M\n2XdHoCvVvm2/vU5DkFTatXzw2+9APGz/4zGaeHtOc5cx0+sl27MV0ISZAoGANtAc\n2NgIzUwnjADB/BDFiEgZlpGnGQLiZYfRVUATFe6EC1wRORwOLd6zMTyRdnB/WzDY\nD1Jp/5SqEg13tNkfEToNXZpWJfOEiLJOsQGDuwEdvJ/5JBlHQqT0v313BA4pL96o\nWdhy+CiT7UifBpC4USczhS29g5au09itytEkj1ECgYEAix6+CwBtbk/gdZFztQEB\nOeWZvGxH+xqX0RTgadbUB4QQw7qEOrbEmkhghSHupiMfcReqgP3mpmLulmUGWhn9\nKJUrXVuoK7bFhByK4h0jFPS37Eg2JcvNCOm0y+InRg+8ZGKQFuyYtg+tn/f5dGUt\nHWQTwxU+nwMriWpExC3DF5A=\n-----END PRIVATE KEY-----\n",
  "client_email": "menu-lists@topincity-374315.iam.gserviceaccount.com",
  "client_id": "101085540771971410627",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/menu-lists%40topincity-374315.iam.gserviceaccount.com"
}
  ''';
