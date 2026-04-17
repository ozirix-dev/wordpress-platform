# Local To Hostinger Parity Map

Tama parity-map kertoo, mita localissa pitaa tietaa, mika on Hostinger-vastine
ja mita site-repoon kuuluu dokumentoida.

| Asia | Mita localissa pitaa tietaa | Hostinger-vastine | Mita ei saa olettaa | Miten kirjataan site-repoon |
| --- | --- | --- | --- | --- |
| Local identity | Mihin WordPress-harnessiin site-repon `wp-content` synkataan | Ei suoraa vastinetta; Hostinger on runtime-target | Ettei local stack automaattisesti vastaa Hostinger-PHP:ta, pathia tai plania | `local_stack`, deployment-muistio |
| Site repo identity | Mikä repo omistaa taman sivuston versionhallittavan koodin | Yksi Hostinger website / yksi WordPress-asennus on oletusvastine | Ettei yksi support-repo olisi deploy-source-of-truth yhdelle live-sivustolle | `site_slug`, `repo_path`, `github_repo` |
| Hostinger website identity | Sivuston nimi ja domainit | Website Dashboard hPanelissa | Ettei domain yksin kerro oikeaa hosting-kohdetta tai plania | `hostinger_website_name`, `primary_domain`, `secondary_domains` |
| Runtime path | Mista localissa teema/plugins/mu-plugins kaynnistyvat | Root path ja `public_html` Hostingerissa | Ettei `public_html` olisi aina ainoa deploy-polku kaikille malleille | `hostinger_root_path`, `hostinger_public_path` |
| Deploy path | Mita package-helper tuottaa ja minne paketti kohdistuu | Git deploy install path tai manuaalinen siirtopolku | Ettei tyhja install path ja `./public_html` olisi eri asioita; docin mukaan molemmat voivat osoittaa juureen riippuen sivustosta | `deployment_method`, tarvittaessa `hostinger_git_install_path` deployment-dokiin |
| PHP version | Mita PHP-versiota localissa kannattaa peilata | hPanel PHP Configuration | Ettei current local PHP riittaisi todisteeksi Hostinger-paritysta | `hostinger_php_version`, config-notes deployment-dokiin |
| Database access | Millainen schema/site-config localissa odotetaan | Database name, database user, phpMyAdmin-entry | Ettei database credentials kuuluisi GitHubiin tai site-profileen kokonaisina | `database_name`, `database_user`, `phpmyadmin_entry_path` |
| Staging availability | Tarvitaanko erillinen staging ennen livea | Hostinger staging, jos plan ja WordPress detection tukevat | Ettei staging olisi aina saatavilla edes WordPress-siteilla | `hostinger_staging_available`, `staging_url` |
| SSH availability | Tarvitaanko shell- tai key-based access | SSH Access hPanelissa | Ettei SSH olisi aina kaytossa tai sama kaikilla plan-tuotteilla | `hostinger_ssh_enabled`, mahdollinen komento deployment-dokiin |
| Git deploy availability | Voidaanko deploy-pathia hallita Gitista | Advanced -> Git -nakyma | Ettei Git deploy tarkoittaisi koko WordPress-asennuksen omistusta | `hostinger_git_deploy_enabled`, deployment-doki |
| Cron model | Tarvitaanko ajastettuja tehtavia | Cron Jobs hPanelissa, UTC+0 | Ettei WordPress cron, Hostinger cron ja taustaprosessit olisi sama asia | `cron_in_use`, notes |
| Uploads/data boundary | Mita local fixtureissa voidaan synkata ilman dataa | `wp-content/uploads` ja live-data pysyvat Hostinger-runtimessa | Ettei uploadsia, backuppeja tai DB-dumppeja siirreta GitHubin kautta | `tracked_in_repo`, `not_tracked_in_repo` |
| Secrets boundary | Miten salaisuudet erotetaan koodista | hPanel, vault, local secure storage | Ettei SSH key, DB password tai API-secret kuuluisi site-repoon | notes + erillinen secure handling, ei secret-kenttia starteriin |

## Kaytannon saanto

Parity tarkoittaa dokumentoitua yhteensopivuutta, ei identtista ymparistoa.

- localissa pitaa kyeta tuottamaan sama repo-managed `wp-content`-kerros, joka
  voidaan turvallisesti vieda Hostingeriin
- site-repon docsien pitaa kertoa, mihin Hostinger-siteen kyseinen kerros
  kuuluu
- kaikki plan-sensitive kohdat merkitsevat "verify in hPanel", eivat "oleta"
