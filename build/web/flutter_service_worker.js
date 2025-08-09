'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "1526576f87205562e71500c64b16ee6a",
"version.json": "719491c0973ca30b0eb15cc621c5cf8f",
"splash/img/light-2x.png": "b6e651e169d8f9ddd4edc4307a666f89",
"splash/img/branding-4x.png": "4c88385b264d3327b0beacd5b94354f7",
"splash/img/dark-4x.png": "443a7aa95781e35c1420efe174abff9c",
"splash/img/branding-dark-1x.png": "81960d07f0d86ca0383c4f191f6d6c68",
"splash/img/light-3x.png": "587195c88ca871945638201b902e45ea",
"splash/img/dark-3x.png": "587195c88ca871945638201b902e45ea",
"splash/img/light-4x.png": "443a7aa95781e35c1420efe174abff9c",
"splash/img/branding-2x.png": "d126d11c8662fed693d72032b7dae69f",
"splash/img/branding-3x.png": "f24ab21453ba6f61e3a4f79e4c46cea7",
"splash/img/dark-2x.png": "b6e651e169d8f9ddd4edc4307a666f89",
"splash/img/dark-1x.png": "1e43f2570c02aa7aabc7b59895558d52",
"splash/img/branding-dark-4x.png": "4c88385b264d3327b0beacd5b94354f7",
"splash/img/branding-1x.png": "81960d07f0d86ca0383c4f191f6d6c68",
"splash/img/branding-dark-2x.png": "d126d11c8662fed693d72032b7dae69f",
"splash/img/light-1x.png": "1e43f2570c02aa7aabc7b59895558d52",
"splash/img/branding-dark-3x.png": "f24ab21453ba6f61e3a4f79e4c46cea7",
"index.html": "c8b28c8c44b30b473d8f17887fe9ac31",
"/": "c8b28c8c44b30b473d8f17887fe9ac31",
"main.dart.js": "a7ae337436551b056fbe57c1f693e679",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "b15c0ae7ec13f83ef34c59aac39b7379",
"icons/Icon-192.png": "fff3ddbf4a0108f84391d7e385055f15",
"icons/Icon-maskable-192.png": "fff3ddbf4a0108f84391d7e385055f15",
"icons/Icon-maskable-512.png": "0137f63b2a1c4e932b3c4547d600189b",
"icons/Icon-512.png": "0137f63b2a1c4e932b3c4547d600189b",
"manifest.json": "ad4382855ae9c70ef31cd81257ccd17f",
".git/config": "a569b56f009230a8fd6afaebfd3c6aab",
".git/objects/61/5fc30c686019fb668b3d68b7217dd9ab926e00": "1b0a13ab404376bbeabbd1dae81c1b7e",
".git/objects/59/c8ced267c77508e94af3442f03c02948bcdda3": "33842828416d32920f4c979c05bf26f2",
".git/objects/50/0a00f9385debc97890e8c5303bb794fb64a97a": "c42c0a7befe7bb1c17c98eac9eb9d83a",
".git/objects/50/8d79a383fc75d11ac23e23c24f64d48e6c9538": "4cdb754dfc148d110f8446be7f0c6a2f",
".git/objects/68/3962639218a53e11d7cdcf8592f02021e66d92": "40d9a6b4ee2e9e2b2501ba47256132ff",
".git/objects/9b/d3accc7e6a1485f4b1ddfbeeaae04e67e121d8": "784f8e1966649133f308f05f2d98214f",
".git/objects/56/3271beb97e229435f23c7b96bed4c0fe912c48": "bf8a18d43e43d6c1a21e9a8d249175f8",
".git/objects/56/913976944bec76d26036e7dcf422b1bf68fe5f": "83e39b48291c8255d847b414b916bc28",
".git/objects/94/418b3200d6ae50af57f6f6fe6d8060bd03b023": "5f08d121d8b15dd80e49513cdea2f12f",
".git/objects/0e/7b73369cb7a1f194f643444e7a035313f8ac8a": "5445bad4cc29cc922b2ad0539b7c0bb5",
".git/objects/60/0789d0a7153309cb0e64be281f9108883da0e9": "191b32e0e46a26c4b9195319d9e193ec",
".git/objects/34/f517dae16f887a48d71769df145d94cb31bbda": "bf0d2440bcb3cef5b62e963f93ec6950",
".git/objects/34/b10bcc89b285237b76832d9be8826926cead8d": "c88acc1e1124934f234f87d29d9620d7",
".git/objects/d9/82af86e41e3c9b20cf8732e7f504ae14b16a73": "e377140b18915cdf03ddecf86c90bc15",
".git/objects/d8/7941f9f4b29fd7534f71f4ba1798f585cb2985": "227794251c6d3f9e3f4241a3d2fe4a2c",
".git/objects/ab/0d1716484cc190b5b8c23f4253eef227c28ba2": "484a55014cc224fccbe925b0b508ea73",
".git/objects/e5/000152375e7610edc687271b8eb4247e93f1cb": "85d9b135694f61b863381384d8adb483",
".git/objects/e2/1129f739a0a0e1b54acff636310f01920d5a6d": "2311196b40d2aaef560a5b74cbde5984",
".git/objects/ee/0e319c5539dbb17d9167d3b7194b5e1a963b42": "b8904b0dc33f998f23b01fa587059178",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/e3/7048c41cb2ef5d58e52642a22f6905facbd412": "f7ccd86fb22561457dcfc5b92e9332ba",
".git/objects/ca/c14085d46c2254fd893471dea9e0e616cfe571": "55ca3682672114df2c4f81e274b653c7",
".git/objects/c8/08fb85f7e1f0bf2055866aed144791a1409207": "92cdd8b3553e66b1f3185e40eb77684e",
".git/objects/fb/359314c241d6b513bdae44f52ebd1c92f7d5a8": "9179a46177035ec20f4c3b3f583063e5",
".git/objects/4e/76b6f253d47bebee96046395a3997223ce89fc": "5945413749dcf16987d909dfd8793023",
".git/objects/45/80f9a53af9111af4715f8c0885289da54e8133": "9d1dec328258edcffaac38ac1691b1f3",
".git/objects/1f/587b2159bd617948f33d64a0414905d52f98fd": "ba1107a3930b9cf24491e92651ff0b65",
".git/objects/73/c63bcf89a317ff882ba74ecb132b01c374a66f": "6ae390f0843274091d1e2838d9399c51",
".git/objects/1a/d7683b343914430a62157ebf451b9b2aa95cac": "94fdc36a022769ae6a8c6c98e87b3452",
".git/objects/8f/9ad57b87626b17d2d9c4fe4273c034e8bd69d8": "8445f8f4bad1679cf719520adb7e41d5",
".git/objects/10/fa9c686b54fdab8660261300a22e95656aca4a": "7cd8d7f4f35389fc898118688286d145",
".git/objects/19/0c663adb6b447107f20eade03b47810aaa1de5": "6421121ad93f5556ac7bc599f4707523",
".git/objects/4c/15d37ac86495e16f2ed9310275c1b92c0b72be": "44e65353b4588d8f3fb67d4a848610e3",
".git/objects/26/ae6160f3d1634ca7a3f6425c3ae8a8d2a59af3": "1578c231a1e953c1527f37b3f22bec36",
".git/objects/26/ceb3b21f1854aeed3d6ebeb0bc8eab0e013cb1": "ee62d0a9ba1ebb98ac543b563cbce553",
".git/objects/26/3de387e84a18d8f0c519e00b72c6791866fcfa": "3b05e1dafefd4f84f26bb76ff86c34ad",
".git/objects/21/7f9c718ed8389bfa49e806e289a2d4f56cd55f": "4df6ae0a11af635a4f000341d693f05d",
".git/objects/75/2a8ff0cf9db435b27451524dc05b63501e8c74": "0636351368b30f6385c8e2f3b23be974",
".git/objects/44/371f45ef618466fce725b9062613bac7fc41cf": "03fd4e6c782833710ecd2bdcd7442a4b",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/00/a2ff14e1a8329d5f526acb836ecaf448dac492": "1131ec54f962acd08c1f45b25fa07733",
".git/objects/6e/d318f4cdf2d2ee3f540a7094124a1e0ef7c203": "fe83a75d5150260c2b6c03664d5835ad",
".git/objects/36/d987b3ede65be9cf313063ce9a23847aecef49": "55136c5231b0cb8584039127e69ca6bc",
".git/objects/36/6942206ec664ba0e0acd5beb75569fa81edb79": "f93803953c612df25d4e054db561c14b",
".git/objects/65/8895e79060104f0726f09a6fc27851c6788f53": "b11d032bc419c2d09412693be9fe6ff6",
".git/objects/54/066938b0dba7f379f391498193a8d14f8e46a7": "521ee68aeadb728ea0e53e1092b44b97",
".git/objects/53/18a6956a86af56edbf5d2c8fdd654bcc943e88": "a686c83ba0910f09872b90fd86a98a8f",
".git/objects/53/3d2508cc1abb665366c7c8368963561d8c24e0": "4592c949830452e9c2bb87f305940304",
".git/objects/5e/11a326f3a4e2df0be59ec4be021b78da2fb97c": "6024b33220ca53f21e42c27c4fffc616",
".git/objects/52/a04b6af76ebd7a1d8d916fa3182b1e89aa500e": "06c30f91dc4f8924804d786a848e7340",
".git/objects/55/e4343421fa3ae236c48ea2f63405becf428883": "b1121d5e999c12038d55f7f1dfeb878d",
".git/objects/0f/27e76994ddc478a3e231675cc98125a0c9325d": "d7928e5fc28d46e91538f56bf0af0b41",
".git/objects/64/17dd2a4ceed8a43a91cd7cd6c506fa70823a97": "11ead55d1057f85efe94d722e8afe8f7",
".git/objects/bf/fbf4f364e6b9536b4906b16b79ab8085a50ca5": "b9b5bab7d635e73efd3fff82e2b9d96d",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/a0/076cabd26a09d4d1b68b5ef6467041cfdacf1d": "b18e0b5d5fbb89c3fed6811ea1efc332",
".git/objects/a7/3c0fef8e08bfefb2508604cb57ed60c94623ac": "4a713a96bd0fa9bbc8c9c06b5b155ea3",
".git/objects/a7/fd2ede06fd772e28fea4a63e08f8eba2d2af0c": "36ef4109abf2f8d400973bb3c8cfd6ef",
".git/objects/dc/11fdb45a686de35a7f8c24f3ac5f134761b8a9": "761c08dfe3c67fe7f31a98f6e2be3c9c",
".git/objects/d2/c6057b478da1ba4971b9437e7785928f6e599c": "643978eb993fd424eb05955adc0ba5d2",
".git/objects/af/6510b65b24e4fd89bc3d5f50e820663b6ad787": "8fd618eb29b0424dcf0996de508e4a30",
".git/objects/db/3e6350e6075e411f5671c43358bf601e40ef81": "3f6be3635fc75f5831a6c2c07e42750f",
".git/objects/a8/1233ff7a40883d86120c024de3a2f09de32ac2": "975d9b3d4df4990fe42e798a0a278ed5",
".git/objects/b9/6a5236065a6c0fb7193cb2bb2f538b2d7b4788": "4227e5e94459652d40710ef438055fe5",
".git/objects/c3/174cfb8b4186e63699a2ef962b740ae299a9b5": "17f43deb65e941e939a89714f6f91909",
".git/objects/cd/4dd97bd36d12a9486176bf1c2d66f250daf342": "08b29ac1fea4eae612cc49aebe2ef9db",
".git/objects/c5/233468375e5d70287ba39597d6d02ec5f97f2c": "a7cb786ffb3d282ab09046edf14fc43f",
".git/objects/c2/e81a298704b2c9f1ea24b7e8040300a37e2a05": "983b43e375f29454d9e5ea10763a0a32",
".git/objects/e9/424a6f6da45c02a4a0b674e57c26c0cd80d906": "842150167d140bc4d05c667eca298458",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/f1/5de52aebd02d4bc4c955392e545f43462ccc38": "7b3c4695662a6a3adc45d9e041ad0b3e",
".git/objects/e0/7ac7b837115a3d31ed52874a73bd277791e6bf": "74ebcb23eb10724ed101c9ff99cfa39f",
".git/objects/2c/71191bd848340ae024046325c3f833cc1f9621": "333fecbb97f4ffdb82ec3c3c6decc049",
".git/objects/2d/b8b355494dd550fc307b43982f56d12846857d": "c175cc66bbd900a06f277de2e6aa6574",
".git/objects/83/25c03324fe07d6c3c265ec7b43ae3c28826a5d": "8dc3da071387c0ae0af0f2a5dfe78eca",
".git/objects/83/9fb912cc4d29ff7b9be8525b48a34b95ed2260": "59c2f3ae2428aacc68ef68647517ffa5",
".git/objects/70/a234a3df0f8c93b4c4742536b997bf04980585": "d95736cd43d2676a49e58b0ee61c1fb9",
".git/objects/70/fda746863b8d46dd093889f4ccc6ade1ab0f26": "565ff92d131a334eeb5d2c4a1332d143",
".git/objects/70/a3b3cfcb1bbcce1fa85a38a9332b6e6e371706": "43de2665fcf2b07e67725a1224a61a86",
".git/objects/1e/b81624ec63f883ad81aea0f678f5fd57f5bd5d": "d1d9e2ff070b748bb3a7064b9b2e786f",
".git/objects/4f/0549ba77cc4d838a45cc1f2705f5ea3cbb90c5": "2213ce85b21b7251cc71c3d536f58f2a",
".git/objects/4f/f8d2673389cacbf447671f563e2fbc4a71db1f": "649c68d809a13267e0185aba4e8cecae",
".git/objects/15/11874fa88a3680168b5041175adb5ca533bd11": "088dc7313eb6165d139e023906e317ad",
".git/objects/1d/1a335c8628ae4ea46ddab807f4b3f4f7eb6feb": "4081f95a97840828b53164cb02651bfa",
".git/objects/76/32af03dc07f894baa8ec51d842fd748c3c5e99": "d6b783fb3b17b803dba719cea484bf60",
".git/objects/1c/7050c9b4c29c281897071f9e89aa15fa645ff8": "7e1ad3014e52ca9e8e426cf37c2f845f",
".git/objects/49/07c372258d2e0926639e6730818356d0d6ae54": "20915349c5ecf7536be2780de60be56d",
".git/objects/40/19cf1914dcfec514dc2db789bbc7d42292d0a1": "527e5dee9bd05b94a8ecf689cb3a4a2e",
".git/objects/2e/6fc526591609ee9619f09c22d4a3640c306415": "678204d0837f57572b7feeb670c8ec8a",
".git/objects/7f/35e4b74f01ebef662f0eaba1abf38112f28cd1": "b9c3682d4b2b3742923dfd7888f811ed",
".git/objects/7f/ba1e719a2bfe9b37b52a993cddb82b82f733ea": "08e3a2d833eee0e2d6d2566dee5cfba9",
".git/objects/7a/941f7a9967721aab318b429323a8c7d6a66652": "fcaec9f17b4d019a489667512431338c",
".git/objects/8e/a533f6fee33429bbf9b30cd5ee4058597790fd": "fa9dd62edb8963e3e32310ff2ecd49dc",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "0d1e888596933d054ed3b2b0636876b8",
".git/logs/refs/heads/main": "a76bf0cc00e9fc204624ed4ea13b0e3c",
".git/logs/refs/remotes/origin/main": "2328d58accd9254039db5c4e68719ad8",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/main": "93bfbf2f4f839697dcf961d250f173db",
".git/refs/remotes/origin/main": "93bfbf2f4f839697dcf961d250f173db",
".git/index": "7a891b75f0441ae633c538b3434746bf",
".git/COMMIT_EDITMSG": "85eaf9192f88fe2e6b553b9a70e6f967",
"assets/AssetManifest.json": "f968ed43536123fb421685fa097e7a61",
"assets/NOTICES": "47a1dafeba16804b36a6fd16eeeb83c2",
"assets/FontManifest.json": "db8f453ee5bd623ef9ffbe9d7a009cf7",
"assets/AssetManifest.bin.json": "df48ea40e5f474a89fb1a7174557058e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "9c750ab64d35e32817e20df13bef59de",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "2cd6498dac4889dabdc60c37b3ba11ec",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "1c12f0d3b117cb5eb965fd678a06bdcd",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "13cb9880835a2703ce2ff896a388bb23",
"assets/fonts/MaterialIcons-Regular.otf": "8e2dfd650e9a7e7fe5657aef13a2ed0f",
"assets/assets/svg/sale_icon.svg": "5f36d22946d707adee021d823367543f",
"assets/assets/svg/search_icon.svg": "d338e04e137d6465f75ea3c8c81257a0",
"assets/assets/svg/home_icon.svg": "36f5a7f3e880d4965d6bf01489a5717b",
"assets/assets/svg/list_cards.svg": "0a0bcf57ef565c92724a3883076adb14",
"assets/assets/svg/trading_icon.svg": "cf65b77a325498927dc5412cf9c60c61",
"assets/assets/svg/deck_icon.svg": "369629a30d8ca38499f7a0f320a62919",
"assets/assets/svg/card_fight.svg": "89d974d69bf01166fa08d1acce802438",
"assets/assets/svg/pokeball_b&w.svg": "5607fcbf5d9e8735e49ab78702420ff8",
"assets/assets/svg/cards.svg": "8fa4aa1e785d58e85e5f8d91c98cbef7",
"assets/assets/images/types_badge/eletric.png": "739fbd7518bf5e5bf62ca63e30ad46ae",
"assets/assets/images/types_badge/dark.png": "ba1929ebf09a7190a261a7727c160db7",
"assets/assets/images/types_badge/fire.png": "ead2c8827a816fe664f04d7687b14c8b",
"assets/assets/images/types_badge/dragon.png": "512c23d8899d2d129f429226decbce4c",
"assets/assets/images/types_badge/fairy.png": "439dded05dddc1734f988e465f95a42d",
"assets/assets/images/types_badge/grass.png": "3a46c2d6a73c53bd9aa293ca239635f0",
"assets/assets/images/types_badge/water.png": "604730b529040df42d278ea20ab8fbc6",
"assets/assets/images/types_badge/normal.png": "ff5bed5bf20ca33a8de8453ccb9b5170",
"assets/assets/images/types_badge/psychic.png": "58b355a7f71ec9438891fc258e73538d",
"assets/assets/images/types_badge/fighting.png": "d1c2231540bfbeb1b44ef35103faf56d",
"assets/assets/images/types_badge/steel.png": "cd94a5ca560c762456fe5cdda9d4e973",
"assets/assets/images/arrow-right.png": "14d99c1517ca89551e6805c1c9c42ae1",
"assets/assets/images/logo_text.png": "b1f57dd6bab13a53023d3ef0e6f53789",
"assets/assets/images/icon-pokeball.png": "14d96b1d552ac1dd296a0d43664c269b",
"assets/assets/images/card-back.png": "384c3ecdf1ee190668b281e942a10cf6",
"assets/assets/images/pokeball.png": "5a1f67e65b8f1b1fc16c7f8c5c748a23",
"assets/assets/images/logo.png": "fcca65c8c5d01de52d2e170013fcee6c",
"assets/assets/images/logo2.png": "a9120794c1c3b60b13cc89282fd633ca",
"assets/assets/images/pokeballs.png": "f770de23df90644be640456e5c63118f",
"assets/assets/images/tabs_icons/trading.png": "777a0faa898135a5386311165b40c560",
"assets/assets/images/tabs_icons/search.png": "4780234936a96db072dfa8482c78dfbc",
"assets/assets/images/splash_bg.png": "e39f838109c236e032304dad1ed28e9d",
"assets/assets/icon/icon_launcher.png": "30b85e4581d2f8010e7ba14f34605128",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
