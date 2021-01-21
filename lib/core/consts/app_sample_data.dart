import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/app_payment_methods.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/notification_type.dart';
import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/enums/share_status.dart';
import 'package:storeangelApp/core/enums/varify_status.dart';
import 'package:storeangelApp/core/models/address.dart';
import 'package:storeangelApp/core/models/chat_message.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/models/payment_option.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/models/rating_model.dart';
import 'package:storeangelApp/core/models/user.dart';

class AppSampleData {
  static List<String> languages_en = [
    'Austria',
    'German',
    'English',
    'English (United States)',
    'Spanish',
    'French',
    'Netherlands'
  ];
  static List<String> languages_de = [
    'Österreich',
    'Deutsch',
    'Englisch',
    'Englisch (USA)',
    'Spanisch',
    'Französisch',
    'Niederländisch'
  ];
  static List<String> units = ["Stk", "Ltr", "ml", "kg", "gr", "mg"];

  static List<OrderByStore>orderByStoreList=[
    OrderByStore(
      storeDetails: StoreDataModel(
        name: 'REWE',
        steetNo: '2',
        image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
        street: 'Domstrasse 20 ',
        txtZip: '50668',
        city: 'Nürnberg',
      ),
      clients: [
        ClientDetails(
            streetNo: '3',
            name: 'Jakob Merz',
            street: 'Knesebeckstrasse 76',
            city: 'Nürnberg',
            zip: '92323',
            imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
        ClientDetails(
            streetNo: '3',
            name: 'Jakob Merz',
            street: 'Knesebeckstrasse 76',
            city: 'Nürnberg',
            zip: '92323',
            imageUrl:
            'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-george-clooney-gettyimages-178273260.jpg'),

      ],
      orderAmount: 250,
      orderTime: DateTime.now().subtract(Duration(minutes: 10)),
      products: [
        Product(
            name: 'Wagyu Beef Ribeye Steak',
            imageUrl:
            'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
            quantity: 2,
            price: 3,
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
            availableStatus: AvailableStatus.plenty,
            storeDetails: StoreDataModel(
              name: 'REWE',
              steetNo: '2',
              image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
              street: 'Domstrasse 20 ',
              txtZip: '50668',
              city: 'Nürnberg',
            )),
        Product(
            name: 'Semi Skimmed Milk',
            imageUrl:
            'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
            quantity: 10,
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
            price: 2,
            availableStatus: AvailableStatus.few,
            storeDetails: StoreDataModel(
              name: 'REWE',
              steetNo: '2',
              image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
              street: 'Domstrasse 20 ',
              txtZip: '50668',
              city: 'Nürnberg',
            )),
        Product(
            name: 'Orangic Black Peppercorns',
            quantity: 1,
            price: 2,
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
            imageUrl:
            'https://i5.walmartimages.com/asr/dd80f1d3-6347-4cff-a3f5-89333367f804.c16c18b1bf6febd8fc208e4033d59e15.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
            availableStatus: AvailableStatus.runOut,
            storeDetails: StoreDataModel(
              name: 'REWE',
              steetNo: '2',
              image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
              street: 'Domstrasse 20 ',
              txtZip: '50668',
              city: 'Nürnberg',
            )),
        Product(
            name: 'Red Bull Energy Drink',
            quantity: 1,
            price: 2,
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
            imageUrl:
            'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
            availableStatus: AvailableStatus.unknown,
            storeDetails: StoreDataModel(
              name: 'REWE',
              steetNo: '2',
              image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
              street: 'Domstrasse 20 ',
              txtZip: '50668',
              city: 'Nürnberg',
            )),
      ]
    ),
  ];
  static List<OrderOrPurchases> courierOffers = <OrderOrPurchases>[
    OrderOrPurchases(
        orderID: 'O1',
        orderAmount: 350,
        comment: 'When you deliver, please do not ring the bell. My baby can sleep. Just call me and I’ll meet you.',
        orderPayment: 'Pending',
        clientDetails: ClientDetails(
            streetNo: '3',
            name: 'Jakob Merz',
            street: 'Knesebeckstrasse 76',
            city: 'Nürnberg',
            zip: '92323',
            imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
        storeDetails: StoreDataModel(
          name: 'REWE',
          steetNo: '2',
          image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
          street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',
        ),
        purchaseDetails:
            PurchaseDetails(paymentOption: PaymentOption(paymentOptionEnum: PaymentOptionEnum.prepayment), products: [
          Product(
              name: 'Wagyu Beef Ribeye Steak',
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              quantity: 2,
              price: 3,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
              availableStatus: AvailableStatus.plenty,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Semi Skimmed Milk',
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              quantity: 10,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
              price: 2,
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Orangic Black Peppercorns',
              quantity: 1,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/dd80f1d3-6347-4cff-a3f5-89333367f804.c16c18b1bf6febd8fc208e4033d59e15.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Red Bull Energy Drink',
              quantity: 1,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.unknown,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Mizani 25 Miracle Milk leave',
              quantity: 2,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/c95d86a3-43de-4a29-b887-696c4b2f7ff7_1.7d76071a15118dad24256c201aebd915.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Great Value Original Soymilk',
              quantity: 10,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/5b27d3f9-1fcc-4300-b96b-ae576f6d184b_2.7999df8a262568356848e28ed7009150.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Short-grain rice',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
              price: 2,
              imageUrl:
                  'https://i5.walmartimages.com/asr/072ec72d-30a2-4cb9-b929-743c99ab3815_1.12fe1f13b22c5ffc35ccf9b26d61ad7c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              availableStatus: AvailableStatus.plenty,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
            name: 'Organic Black Peppercorns',
            quantity: 1,
            price: 5,
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
            imageUrl:
                'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
            availableStatus: AvailableStatus.plenty,
          ),
          Product(
            name: 'Organic Black Peppercorns',
            quantity: 1,
            price: 5,
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl:
                    'https://www.google.com/imgres?imgurl=https%3A%2F%2Fi.pinimg.com%2Foriginals%2Fed%2F18%2F91%2Fed189191dc22169f0e6786a85f068616.jpg&imgrefurl=https%3A%2F%2Fin.pinterest.com%2Fpin%2F673710425477850462%2F&tbnid=Z9ob-bmDnmJawM&vet=12ahUKEwirmeGDo__sAhUKQH0KHct-CfYQMygKegUIARDsAQ..i&docid=RXkt-PYKFlOJ2M&w=2592&h=3872&q=passport%20size%20photo&hl=en&ved=2ahUKEwirmeGDo__sAhUKQH0KHct-CfYQMygKegUIARDsAQ'),
            imageUrl:
                'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
            availableStatus: AvailableStatus.plenty,
          ),
          Product(
            name: 'Organic Black Peppercorns',
            quantity: 1,
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
            price: 5,
            imageUrl:
                'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
            availableStatus: AvailableStatus.plenty,
          ),
        ]),
        quantity: 10,
        status: OrderPurchaseStatus.Rejected,
        selectedDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
        timeDuration: '17:00 - 20:00'),
    OrderOrPurchases(
      orderID: 'O2',
      comment: 'When you deliver, please do not ring the bell. My baby can sleep. Just call me and I’ll meet you.',
      purchaseDetails: PurchaseDetails(
        paymentOption: PaymentOption(paymentOptionEnum: PaymentOptionEnum.prepayment),
        products: [
          Product(
              name: 'Wagyu Beef Ribeye Steak',
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              quantity: 2,
              price: 3,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Semi Skimmed Milk',
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              quantity: 10,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
              availableStatus: AvailableStatus.plenty,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Orangic Black Peppercorns',
              quantity: 1,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/dd80f1d3-6347-4cff-a3f5-89333367f804.c16c18b1bf6febd8fc208e4033d59e15.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Red Bull Energy Drink',
              quantity: 1,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.unknown,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Mizani 25 Miracle Milk leave in 13.5oz',
              quantity: 2,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/c95d86a3-43de-4a29-b887-696c4b2f7ff7_1.7d76071a15118dad24256c201aebd915.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Silk Shelf-Stable Chocolate Soymilk Singles',
              quantity: 10,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl: 'https://i.pinimg.com/originals/ed/18/91/ed189191dc22169f0e6786a85f068616.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/8c85e0b1-3639-47c7-8997-5114715dff7d.deede370d942a086b13a143e61fea4a8.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
        ],
      ),
      orderAmount: 350,
      orderPayment: 'Prepayment',
      selectedDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
      timeDuration: '17:00 - 20:00',
      status: OrderPurchaseStatus.Pending,
      clientDetails: ClientDetails(
          streetNo: '3',
          name: 'Jakob Merz',
          street: 'Knesebeckstrasse 76',
          city: 'Nürnberg',
          zip: '92323',
          imageUrl:
              'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-george-clooney-gettyimages-178273260.jpg'),
      storeDetails: StoreDataModel(
        name: 'REWE',
        steetNo: '2',
        image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
        street: 'Domstrasse 20 ',
        txtZip: '50668',
        city: 'Nürnberg',
      ),
      quantity: 10,
    ),
    OrderOrPurchases(
      orderID: 'O3',
      comment: 'When you deliver, please do not ring the bell. My baby can sleep. Just call me and I’ll meet you.',
      purchaseDetails: PurchaseDetails(
        paymentOption: PaymentOption(paymentOptionEnum: PaymentOptionEnum.prepayment),
        products: [
          Product(
              name: 'Wagyu Beef Ribeye Steak',
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              quantity: 2,
              price: 3,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              availableStatus: AvailableStatus.plenty,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Semi Skimmed Milk',
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              quantity: 10,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Orangic Black Peppercorns',
              quantity: 1,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/dd80f1d3-6347-4cff-a3f5-89333367f804.c16c18b1bf6febd8fc208e4033d59e15.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Red Bull Energy Drink',
              quantity: 1,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.unknown,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Mizani 25 Miracle Milk leave in 13.5oz',
              quantity: 2,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/c95d86a3-43de-4a29-b887-696c4b2f7ff7_1.7d76071a15118dad24256c201aebd915.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Great Value Original Soymilk',
              quantity: 10,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/5b27d3f9-1fcc-4300-b96b-ae576f6d184b_2.7999df8a262568356848e28ed7009150.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
        ],
      ),
      orderAmount: 350,
      orderPayment: 'Prepayment',
      status: OrderPurchaseStatus.Pending,
      selectedDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
      timeDuration: '17:00 - 20:00',
      clientDetails: ClientDetails(
        streetNo: '3',
        name: 'Jakob Merz',
        imageUrl:
            'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-george-clooney-gettyimages-178273260.jpg',
        street: 'Knesebeckstrasse 76',
        city: 'Nürnberg',
        zip: '92323',
      ),
      storeDetails: StoreDataModel(
        name: 'REWE',
        steetNo: '2',
        image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
        street: 'Domstrasse 20 ',
        txtZip: '50668',
        city: 'Nürnberg',
      ),
      quantity: 10,
    ),
  ];
  static List<CourierCandidate> candidatesList = [
    CourierCandidate(
        id: 'c1',
        imageUrl: 'https://www.ddpch.com/wp-content/uploads/2020/04/89803.jpg',
        name: 'Zeny Fisher',
        stars: 5,
        reviews: 45,
        totalOrder: 1,
        verifyStatus: VerifyStatus.Varified,
        insurance: true,
        phoneNumber: '(702) 875-4605',
        completedOrders: 1,
        time: '8:00-20:00',
        date: DateTime.now(),
        status: 'In Progress',
        favourite: false,
        ratings: [
          RatingModel(
              rateBy: UserModel(
                id: '1',
              ),
              rating: 3),
          RatingModel(
              rateBy: UserModel(
                id: '2',
              ),
              rating: 3),
        ],
        charge: 10),
    CourierCandidate(
        id: 'c2',
        imageUrl:
            'https://dm0qx8t0i9gc9.cloudfront.net/thumbnails/video/NDcUKEpwx/videoblocks-young-happy-beautiful-delivery-woman-worker-smiling-to-the-camera-cheerfully-holding-cardboard-box-package-with-copy-space-showing-thumbs-up-on-green-background-service_ruesmxgmyg_thumbnail-1080_01.png',
        name: 'Connie Webb',
        stars: 5,
        reviews: 30,
        totalOrder: 90,
        verifyStatus: VerifyStatus.Reliable,
        phoneNumber: '(702) 875-4605',
        completedOrders: 2,
        insurance: false,
        time: '8:00-20:00',
        date: DateTime.now(),
        favourite: true,
        ratings: [
          RatingModel(
              rateBy: UserModel(
                id: '1',
              ),
              rating: 3),
          RatingModel(
              rateBy: UserModel(
                id: '2',
              ),
              rating: 3),
        ],
        charge: 12),
    CourierCandidate(
        id: 'c3',
        imageUrl: 'https://static.toiimg.com/thumb/msid-69029142,width-1200,height-900,resizemode-4/.jpg',
        name: 'Marjorie Miles',
        stars: 4,
        reviews: 24,
        totalOrder: 1,
        verifyStatus: VerifyStatus.Unknown,
        phoneNumber: '(702) 875-4605',
        insurance: false,
        favourite: false,
        time: '8:00-20:00',
        ratings: [
          RatingModel(
              rateBy: UserModel(
                id: '1',
              ),
              rating: 3),
          RatingModel(
              rateBy: UserModel(
                id: '2',
              ),
              rating: 3),
        ],
        date: DateTime.now(),
        completedOrders: 2,
        charge: 15),
    CourierCandidate(
        id: 'c4',
        imageUrl:
            'https://image.freepik.com/free-photo/smiling-young-pretty-delivery-girl-red-uniform-cap-holding-pizza-packages_141793-31534.jpg',
        name: 'Jane Pena',
        stars: 4,
        reviews: 24,
        totalOrder: 1,
        verifyStatus: VerifyStatus.Unknown,
        phoneNumber: '(702) 875-4605',
        insurance: false,
        favourite: true,
        time: '8:00-20:00',
        ratings: [
          RatingModel(
              rateBy: UserModel(
                id: '1',
              ),
              rating: 3),
          RatingModel(
              rateBy: UserModel(
                id: '2',
              ),
              rating: 3),
        ],
        date: DateTime.now(),
        completedOrders: 2,
        charge: 15),
    CourierCandidate(
        id: 'c5',
        imageUrl:
            'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
        name: 'Vanessa Gantikow-Schröder',
        stars: 3,
        reviews: 45,
        totalOrder: 1,
        verifyStatus: VerifyStatus.Varified,
        phoneNumber: '(702) 875-4605',
        insurance: true,
        favourite: true,
        time: '8:00-20:00',
        date: DateTime.now(),
        completedOrders: 2,
        ratings: [
          RatingModel(
              rateBy: UserModel(
                id: '1',
              ),
              rating: 3),
          RatingModel(
              rateBy: UserModel(
                id: '2',
              ),
              rating: 3),
        ],
        charge: 10),
    CourierCandidate(
        id: 'c6',
        imageUrl: 'https://photo-cdn.icons8.com/assets/previews/782/69abd03a-1596-4b51-8e21-3657a4fdb6dd1x.jpg',
        name: 'Connie Webb',
        stars: 4,
        reviews: 30,
        totalOrder: 90,
        completedOrders: 2,
        verifyStatus: VerifyStatus.Reliable,
        phoneNumber: '(702) 875-4605',
        insurance: false,
        favourite: true,
        ratings: [
          RatingModel(
              rateBy: UserModel(
                id: '1',
              ),
              rating: 3),
          RatingModel(
              rateBy: UserModel(
                id: '2',
              ),
              rating: 3),
        ],
        time: '8:00-20:00',
        date: DateTime.now(),
        charge: 12),
    CourierCandidate(
        id: 'c7',
        imageUrl:
            'https://images.unsplash.com/photo-1462804993656-fac4ff489837?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80',
        name: 'Marjorie Miles',
        stars: 3,
        reviews: 24,
        totalOrder: 1,
        completedOrders: 1,
        verifyStatus: VerifyStatus.Unknown,
        phoneNumber: '(702) 875-4605',
        insurance: false,
        favourite: false,
        time: '8:00-20:00',
        ratings: [
          RatingModel(
              rateBy: UserModel(
                id: '1',
              ),
              rating: 3),
          RatingModel(
              rateBy: UserModel(
                id: '2',
              ),
              rating: 3),
        ],
        date: DateTime.now(),
        charge: 15),
    CourierCandidate(
        id: 'c8',
        imageUrl: 'https://www.ddpch.com/wp-content/uploads/2020/04/89803.jpg',
        name: 'Jane Pena',
        stars: 4,
        reviews: 24,
        totalOrder: 1,
        completedOrders: 1,
        verifyStatus: VerifyStatus.Unknown,
        phoneNumber: '(702) 875-4605',
        insurance: false,
        time: '8:00-20:00',
        ratings: [
          RatingModel(
              rateBy: UserModel(
                id: '1',
              ),
              rating: 3),
          RatingModel(
              rateBy: UserModel(
                id: '2',
              ),
              rating: 3),
        ],
        date: DateTime.now(),
        favourite: true,
        charge: 15),
  ];
  static List<PurchaseDetails> wishlist = [
    PurchaseDetails(
        id: '1',
        listName: 'Weekly food',
        storeDetails: StoreDataModel(
            steetNo: '2',
            image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
            name: 'REWE',
            street: 'Domstrasse 20 ',
            txtZip: '50668',
            city: 'Nürnberg',
            openingTime: '9:00',
            closingTime: '22:00'),
        amount: 350,
        customer: UserModel(
            name: 'Jakob Merz',
            imageUrl:
                'https://ath2.unileverservices.com/wp-content/uploads/sites/8/2019/09/hairstyles-for-men-with-round-faces-side-part.jpg'),
        quantity: 9,
        time: DateTime.now(),
        products: [
          Product(
              category: 'GROCERY',
              id: 'g1',
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 2,
              price: 4.32,
              availableStatus: AvailableStatus.plenty,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              category: 'GROCERY',
              id: 'g2',
              name: 'Semi Skimmed Milk',
              quantity: 5,
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              price: 4.32,
              newPrice: 5.34,
              availableStatus: AvailableStatus.few,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
//          Product(
//              id: 'g3',
//              name: 'Organic Black Peppercorns',
//              quantity: 1,
//              imageUrl:
//                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
//              category: 'GROCERY',
//              price: 3.12,
//
//              availableStatus: AvailableStatus.runOut,
//              createdBy: UserModel(
//                  name: 'Vanessa Gantikow-Schröder',
//                  imageUrl:
//                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
//              storeDetails: StoreDataModel(
//                name: 'REWE',
//                image:
//                    'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
//                street: 'Domstrasse 20 ',
//                txtZip: '50668',
//                city: 'Nürnberg',
//              )),
//          Product(
//              id: 'g4',
//              name: 'Red Bull Energy Drink',
//              quantity: 1,
//
//              category: 'GROCERY',
//              price: 11.11,
//              imageUrl:
//                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
//              availableStatus: AvailableStatus.unknown,
//              createdBy: UserModel(
//                  name: 'Vanessa Gantikow-Schröder',
//                  imageUrl:
//                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
//              storeDetails: StoreDataModel(
//                name: 'REWE',
//                image:
//                    'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
//                street: 'Domstrasse 20 ',
//                txtZip: '50668',
//                city: 'Nürnberg',
//              )),
//          Product(
//              id: 'g4',
//              name: 'SNICKERS Chocolate Lowfat Milk',
//              quantity: 1,
//
//              category: 'GROCERY',
//              price: 11.11,
//              imageUrl:
//              'https://i5.walmartimages.com/asr/1a4d04e2-08a8-4887-a81f-f900b8acfeb0.4e46924d62e48379644d1bd3c40a5080.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
//              availableStatus: AvailableStatus.unknown,
//              createdBy: UserModel(
//                  name: 'Vanessa Gantikow-Schröder',
//                  imageUrl:
//                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
//              storeDetails: StoreDataModel(
//                name: 'REWE',
//                image:
//                'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
//                street: 'Domstrasse 20 ',
//                txtZip: '50668',
//                city: 'Nürnberg',
//              )),
//          Product(
//              id: 'g4',
//              name: 'Great Value 1% Chocolate Milk, Half Gallon',
//              quantity: 1,
//
//              category: 'GROCERY',
//              price: 11.11,
//              imageUrl:
//              'https://i5.walmartimages.com/asr/5e3107e9-ca85-41f4-9ee5-f028e71fc8d8_2.023ca795f624f4d161f3f7b66d132577.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
//              availableStatus: AvailableStatus.unknown,
//              createdBy: UserModel(
//                  name: 'Vanessa Gantikow-Schröder',
//                  imageUrl:
//                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
//              storeDetails: StoreDataModel(
//                name: 'REWE',
//                image:
//                'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
//                street: 'Domstrasse 20 ',
//                txtZip: '50668',
//                city: 'Nürnberg',
//              )),
        ]),
    PurchaseDetails(
        listName: 'Household',
        storeDetails: StoreDataModel(
            steetNo: '2',
            image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
            name: 'REWE',
            street: 'Domstrasse 20 ',
            txtZip: '50668',
            city: 'Nürnberg',
            openingTime: '9:00',
            closingTime: '22:00'),
        amount: 4,
        customer: UserModel(
            name: 'Joson Flores',
            imageUrl:
                'https://dmn-dallas-news-prod.cdn.arcpublishing.com/resizer/TP2Goa_wkbClIvFlUeuCKZOpeCM=/1660x934/smart/filters:no_upscale()/arc-anglerfish-arc2-prod-dmn.s3.amazonaws.com/public/EEFXXGI2ONE6FMYGZTIMKXOQAY.jpg'),
        quantity: 9,
        time: DateTime.now(),
        products: [
          Product(
              category: 'GROCERY',
              id: '01',
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 2,
              price: 2.22,
              availableStatus: AvailableStatus.few,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              )),
          Product(
            category: 'GROCERY',
            id: '02',
            imageUrl:
                'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
            storeDetails: StoreDataModel(
              steetNo: '2',
              name: 'Lidl',
              image:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              street: 'Hauptstrasse 6a',
              city: 'Düsseldorf',
              txtZip: '56456',
            ),
            name: 'Semi Skimmed Milk',
            price: 2.32,
            newPrice: 3.34,
            quantity: 5,
            availableStatus: AvailableStatus.runOut,
          ),
          Product(
              id: 'g4',
              name: 'SNICKERS Chocolate Lowfat Milk',
              quantity: 1,
              category: 'GROCERY',
              price: 11.11,
              imageUrl:
                  'https://i5.walmartimages.com/asr/1a4d04e2-08a8-4887-a81f-f900b8acfeb0.4e46924d62e48379644d1bd3c40a5080.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              availableStatus: AvailableStatus.few,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g4',
              name: 'Great Value 1% Chocolate Milk, Half Gallon',
              quantity: 1,
              category: 'GROCERY',
              price: 11.11,
              imageUrl:
                  'https://i5.walmartimages.com/asr/5e3107e9-ca85-41f4-9ee5-f028e71fc8d8_2.023ca795f624f4d161f3f7b66d132577.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              availableStatus: AvailableStatus.few,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              category: 'GROCERY',
              id: '03',
              imageUrl:
                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'Lidl',
                steetNo: '2',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              name: 'Organic Black Peppercorns',
              quantity: 1,
              price: 2.90,
              availableStatus: AvailableStatus.plenty),
          Product(
              category: 'GROCERY',
              id: '04',
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'Lidl',
                steetNo: '2',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              price: 10.05,
              name: 'Red Bull Energy Drink',
              quantity: 1,
              availableStatus: AvailableStatus.plenty),
        ]),
    PurchaseDetails(
        listName: 'Household',
        storeDetails: StoreDataModel(
            steetNo: '2',
            image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
            name: 'REWE',
            street: 'Domstrasse 20 ',
            txtZip: '50668',
            city: 'Nürnberg',
            openingTime: '9:00',
            closingTime: '22:00'),
        amount: 4,
        customer: UserModel(
            name: 'Smrith',
            imageUrl:
                'https://cdn.shopify.com/s/files/1/0092/2969/7086/files/Copy_of_Untitled_3_f1177dac-8a67-4d94-a3df-d88886571d2b.png?v=16406613511003005348'),
        quantity: 9,
        time: DateTime.now(),
        products: [
          Product(
              category: 'GROCERY',
              id: '01',
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 2,
              price: 2.11,
              availableStatus: AvailableStatus.runOut,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'Lidl',
                steetNo: '2',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              )),
          Product(
              id: 'g4',
              name: 'SNICKERS Chocolate Lowfat Milk',
              quantity: 1,
              category: 'GROCERY',
              price: 11.11,
              imageUrl:
                  'https://i5.walmartimages.com/asr/1a4d04e2-08a8-4887-a81f-f900b8acfeb0.4e46924d62e48379644d1bd3c40a5080.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              availableStatus: AvailableStatus.plenty,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g4',
              name: 'Great Value 1% Chocolate Milk, Half Gallon',
              quantity: 1,
              category: 'GROCERY',
              price: 11.11,
              imageUrl:
                  'https://i5.walmartimages.com/asr/5e3107e9-ca85-41f4-9ee5-f028e71fc8d8_2.023ca795f624f4d161f3f7b66d132577.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              availableStatus: AvailableStatus.plenty,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
            category: 'GROCERY',
            id: '02',
            imageUrl:
                'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
            storeDetails: StoreDataModel(
              name: 'Lidl',
              steetNo: '2',
              image:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              street: 'Hauptstrasse 6a',
              city: 'Düsseldorf',
              txtZip: '56456',
            ),
            name: 'Semi Skimmed Milk',
            price: 2.45,
            quantity: 5,
            availableStatus: AvailableStatus.few,
          ),
          Product(
              category: 'GROCERY',
              id: '03',
              imageUrl:
                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'Lidl',
                steetNo: '2',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              name: 'Organic Black Peppercorns',
              quantity: 1,
              price: 2.76,
              availableStatus: AvailableStatus.runOut),
          Product(
              category: 'GROCERY',
              id: '04',
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'Lidl',
                steetNo: '2',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              price: 10.20,
              name: 'Red Bull Energy Drink',
              quantity: 1,
              availableStatus: AvailableStatus.runOut),
        ]),
    PurchaseDetails(
        listName: 'Household',
        storeDetails: StoreDataModel(
            steetNo: '2',
            image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
            name: 'REWE',
            street: 'Domstrasse 20 ',
            txtZip: '50668',
            city: 'Nürnberg',
            openingTime: '9:00',
            closingTime: '22:00'),
        amount: 4,
        customer: UserModel(
            name: 'Thomas Flores',
            imageUrl:
                'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg'),
        quantity: 9,
        time: DateTime.now(),
        products: [
          Product(
              category: 'GROCERY',
              id: '01',
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 2,
              price: 2.21,
              availableStatus: AvailableStatus.few,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              )),
          Product(
            category: 'GROCERY',
            id: '02',
            imageUrl:
                'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
            storeDetails: StoreDataModel(
              steetNo: '2',
              name: 'Lidl',
              image:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              street: 'Hauptstrasse 6a',
              city: 'Düsseldorf',
              txtZip: '56456',
            ),
            name: 'Semi Skimmed Milk',
            price: 2.30,
            quantity: 5,
            availableStatus: AvailableStatus.few,
          ),
          Product(
              category: 'GROCERY',
              id: '03',
              imageUrl:
                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              name: 'Organic Black Peppercorns',
              quantity: 1,
              price: 2.70,
              availableStatus: AvailableStatus.runOut),
          Product(
              category: 'GROCERY',
              id: '04',
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              price: 10.55,
              name: 'Red Bull Energy Drink',
              quantity: 1,
              availableStatus: AvailableStatus.plenty),
        ]),
//    PurchaseDetails(
//        listName: 'Household',
//        storeDetails: StoreDataModel(
//            image:
//                'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
//            name: 'REWE',
//            street: 'Domstrasse 20 ',
//            txtZip: '50668',
//            city: 'Nürnberg',
//            openingTime: '9:00',
//            closingTime: '22:00'),
//        amount: 4,
//        customer: UserModel(
//            name: 'Jakob Merz',
//            imageUrl:
//                'https://ath2.unileverservices.com/wp-content/uploads/sites/8/2019/09/hairstyles-for-men-with-round-faces-side-part.jpg'),
//        quantity: 9,
//        time: DateTime.now(),
//        products: [
//          Product(
//              category: 'GROCERY',
//              id: '01',
//              imageUrl:
//                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
//              name: 'Wagyu Beef Ribeye Steak',
//              quantity: 2,
//              price: 2.54,
//
//              availableStatus: AvailableStatus.few,
//              createdBy: UserModel(
//                  name: 'Vanessa Gantikow-Schröder',
//                  imageUrl:
//                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
//              storeDetails: StoreDataModel(
//                name: 'Lidl',
//                image:
//                    'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
//                street: 'Hauptstrasse 6a',
//                city: 'Düsseldorf',
//                txtZip: '56456',
//              )),
//          Product(
//            category: 'GROCERY',
//            id: '02',
//            imageUrl:
//                'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
//            createdBy: UserModel(
//                name: 'Vanessa Gantikow-Schröder',
//                imageUrl:
//                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
//            storeDetails: StoreDataModel(
//              name: 'Lidl',
//              image:
//                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
//              street: 'Hauptstrasse 6a',
//              city: 'Düsseldorf',
//              txtZip: '56456',
//            ),
//            name: 'Semi Skimmed Milk',
//
//            price: 2.45,
//            quantity: 5,
//            availableStatus: AvailableStatus.plenty,
//          ),
//          Product(
//              category: 'GROCERY',
//              id: '03',
//              imageUrl:
//                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
//              createdBy: UserModel(
//                  name: 'Vanessa Gantikow-Schröder',
//                  imageUrl:
//                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
//              storeDetails: StoreDataModel(
//                name: 'Lidl',
//                image:
//                    'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
//                street: 'Hauptstrasse 6a',
//                city: 'Düsseldorf',
//                txtZip: '56456',
//              ),
//              name: 'Organic Black Peppercorns',
//              quantity: 1,
//              price: 2.54,
//
//              availableStatus: AvailableStatus.runOut),
//
//        ]),
  ];
  static List<PurchaseDetails> notificationList = [
    PurchaseDetails(
        id: '1',
        notificationType: NotificationType.shoppingNotification.notificationValue,
        listName: 'Weekly food',
        paymentOption: PaymentOption(
          title: 'Advance payment'
        ),
        storeDetails: StoreDataModel(
            steetNo: '2',
            image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
            name: 'REWE',
            landMark: 'Hinterdumpenhausen',
            street: 'Domstrasse 20 ',
            txtZip: '50668',
            city: 'Nürnberg',
            webSitUrl: 'https://www.rewe.de/',
            openingTime: '9:',
            closingTime: '22:'),
        amount: 350,
        customer: UserModel(
            name: 'Michael Parker',
            street: 'Domstrasse 20 ',
            zipCode: '50668',
            city: 'Nürnberg',
            imageUrl:
                'https://cdn.shopify.com/s/files/1/0092/2969/7086/files/Copy_of_Untitled_3_f1177dac-8a67-4d94-a3df-d88886571d2b.png?v=16406613511003005348'),
        quantity: 9,
        time: DateTime.now(),
        products: [
          Product(
              id: 'g1',
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 2,
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              category: 'GROCERY',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              price: 4,
              availableStatus: AvailableStatus.plenty,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'REWE',
                image:
                    'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g2',
              name: 'Semi Skimmed Milk',
              quantity: 5,
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              price: 4,
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'REWE',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g3',
              name: 'Organic Black Peppercorns',
              quantity: 1,
              imageUrl:
                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              price: 3,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'REWE',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g4',
              name: 'Red Bull Energy Drink',
              quantity: 1,
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              category: 'GROCERY',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              price: 11,
              availableStatus: AvailableStatus.unknown,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'REWE',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
        ]),
    PurchaseDetails(
        paymentOption: PaymentOption(
            title: 'Advance payment'
        ),
        listName: 'Household',
        notificationType: NotificationType.shareNotification.notificationValue,
        storeDetails: StoreDataModel(
            steetNo: '2',
            image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
            name: 'Lidl',
            landMark: 'Hinterdupfing',
            street: 'Hauptstrasse 6a',
            city: 'Düsseldorf',
            txtZip: '56456',
            webSitUrl: 'https://www.rewe.de/',
            openingTime: '9:',
            closingTime: '22:'),
        amount: 4,
        customer: UserModel(
            name: 'Jakob Merz',
            street: 'Domstrasse 20 ',
            zipCode: '50668',
            city: 'Nürnberg',
            imageUrl:
                'https://ath2.unileverservices.com/wp-content/uploads/sites/8/2019/09/hairstyles-for-men-with-round-faces-side-part.jpg'),
        quantity: 9,
        time: DateTime.now(),
        products: [
          Product(
              category: 'GROCERY',
              id: '01',
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 2,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              )),
          Product(
            category: 'GROCERY',
            imageUrl:
                'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
            id: '02',
            storeDetails: StoreDataModel(
              steetNo: '2',
              name: 'Lidl',
              image:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              street: 'Hauptstrasse 6a',
              city: 'Düsseldorf',
              txtZip: '56456',
            ),
            name: 'Semi Skimmed Milk',
            price: 2,
            quantity: 5,
            availableStatus: AvailableStatus.plenty,
          ),
          Product(
              category: 'GROCERY',
              id: '03',
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              name: 'Organic Black Peppercorns',
              quantity: 1,
              price: 2,
              availableStatus: AvailableStatus.runOut),
          Product(
              category: 'GROCERY',
              id: '04',
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              price: 10,
              name: 'Red Bull Energy Drink',
              quantity: 1,
              availableStatus: AvailableStatus.unknown),
        ]),
    PurchaseDetails(
        id: '1',
        notificationType: NotificationType.shoppingNotification.notificationValue,
        listName: 'Weekly food',
        paymentOption: PaymentOption(
            title: 'Advance payment'
        ),
        storeDetails: StoreDataModel(
            steetNo: '2',
            image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
            name: 'REWE',
            landMark: 'Hinterdumpenhausen',
            street: 'Domstrasse 20 ',
            txtZip: '50668',
            city: 'Nürnberg',
            webSitUrl: 'https://www.rewe.de/',
            openingTime: '9:',
            closingTime: '22:'),
        amount: 350,
        customer: UserModel(
            name: 'Anna Loroff',
            street: 'Domstrasse 20 ',
            zipCode: '50668',
            city: 'Nürnberg',
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/sample_profile.png?alt=media&token=5bbcd983-45aa-4c98-8487-1b8a79650ac7'),
        quantity: 9,
        time: DateTime.now(),
        products: [
          Product(
              id: 'g1',
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 2,
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              category: 'GROCERY',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              price: 4,
              availableStatus: AvailableStatus.plenty,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'REWE',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g2',
              name: 'Semi Skimmed Milk',
              quantity: 5,
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              price: 4,
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'REWE',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g3',
              name: 'Organic Black Peppercorns',
              quantity: 1,
              imageUrl:
                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              price: 3,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'REWE',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g4',
              name: 'Red Bull Energy Drink',
              quantity: 1,
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              category: 'GROCERY',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              price: 11,
              availableStatus: AvailableStatus.unknown,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'REWE',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
        ]),
    PurchaseDetails(
        listName: 'Household',
        notificationType: NotificationType.shareNotification.notificationValue,
        paymentOption: PaymentOption(
            title: 'Advance payment'
        ),
        storeDetails: StoreDataModel(
            steetNo: '2',
            image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
            name: 'Lidl',
            landMark: 'Hinterdupfing',
            street: 'Hauptstrasse 6a',
            city: 'Düsseldorf',
            txtZip: '56456',
            webSitUrl: 'https://www.rewe.de/',
            openingTime: '9:',
            closingTime: '22:'),
        amount: 4,
        customer: UserModel(
            name: 'Jakob Merz',
            street: 'Domstrasse 20 ',
            zipCode: '50668',
            city: 'Nürnberg',
            imageUrl:
                'https://ath2.unileverservices.com/wp-content/uploads/sites/8/2019/09/hairstyles-for-men-with-round-faces-side-part.jpg'),
        quantity: 9,
        time: DateTime.now(),
        products: [
          Product(
              category: 'GROCERY',
              id: '01',
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 2,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              )),
          Product(
            category: 'GROCERY',
            imageUrl:
                'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
            id: '02',
            storeDetails: StoreDataModel(
              steetNo: '2',
              name: 'Lidl',
              image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
              street: 'Hauptstrasse 6a',
              city: 'Düsseldorf',
              txtZip: '56456',
            ),
            name: 'Semi Skimmed Milk',
            price: 2,
            quantity: 5,
            availableStatus: AvailableStatus.plenty,
          ),
          Product(
              category: 'GROCERY',
              id: '03',
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              name: 'Organic Black Peppercorns',
              quantity: 1,
              price: 2,
              availableStatus: AvailableStatus.runOut),
          Product(
              category: 'GROCERY',
              id: '04',
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              price: 10,
              name: 'Red Bull Energy Drink',
              quantity: 1,
              availableStatus: AvailableStatus.unknown),
        ]),
    PurchaseDetails(
        paymentOption: PaymentOption(
            title: 'Advance payment'
        ),
        id: '1',
        notificationType: NotificationType.shoppingNotification.notificationValue,
        listName: 'Weekly food',
        storeDetails: StoreDataModel(
            steetNo: '2',
            image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
            name: 'REWE',
            landMark: 'Hinterdumpenhausen',
            street: 'Domstrasse 20 ',
            txtZip: '50668',
            city: 'Nürnberg',
            webSitUrl: 'https://www.rewe.de/',
            openingTime: '9:',
            closingTime: '22:'),
        amount: 350,
        customer: UserModel(
            name: 'Karin Bernhard',
            street: 'Domstrasse 20 ',
            zipCode: '50668',
            city: 'Nürnberg',
            imageUrl:
                'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg'),
        quantity: 9,
        time: DateTime.now(),
        products: [
          Product(
              id: 'g1',
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 2,
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              category: 'GROCERY',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              price: 4,
              availableStatus: AvailableStatus.plenty,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'REWE',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g2',
              name: 'Semi Skimmed Milk',
              quantity: 5,
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              price: 4,
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'REWE',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g3',
              name: 'Organic Black Peppercorns',
              quantity: 1,
              imageUrl:
                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              price: 3,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'REWE',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g4',
              name: 'Red Bull Energy Drink',
              quantity: 1,
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              category: 'GROCERY',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              price: 11,
              availableStatus: AvailableStatus.unknown,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'REWE',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
        ]),
    PurchaseDetails(
        listName: 'Household',
        notificationType: NotificationType.shareNotification.notificationValue,
        paymentOption: PaymentOption(
            title: 'Advance payment'
        ),
        storeDetails: StoreDataModel(
            steetNo: '2',
            image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
            name: 'Lidl',
            landMark: 'Hinterdupfing',
            street: 'Hauptstrasse 6a',
            city: 'Düsseldorf',
            txtZip: '56456',
            webSitUrl: 'https://www.rewe.de/',
            openingTime: '9:',
            closingTime: '22:'),
        amount: 4,
        customer: UserModel(
            name: 'Jakob Merz',
            street: 'Domstrasse 20 ',
            zipCode: '50668',
            city: 'Nürnberg',
            imageUrl:
                'https://ath2.unileverservices.com/wp-content/uploads/sites/8/2019/09/hairstyles-for-men-with-round-faces-side-part.jpg'),
        quantity: 9,
        time: DateTime.now(),
        products: [
          Product(
              category: 'GROCERY',
              id: '01',
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 2,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              )),
          Product(
            category: 'GROCERY',
            imageUrl:
                'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
            id: '02',
            storeDetails: StoreDataModel(
              name: 'Lidl',
              steetNo: '2',
              image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
              street: 'Hauptstrasse 6a',
              city: 'Düsseldorf',
              txtZip: '56456',
            ),
            name: 'Semi Skimmed Milk',
            price: 2,
            quantity: 5,
            availableStatus: AvailableStatus.plenty,
          ),
          Product(
              category: 'GROCERY',
              id: '03',
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'Lidl',
                steetNo: '2',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              name: 'Organic Black Peppercorns',
              quantity: 1,
              price: 2,
              availableStatus: AvailableStatus.runOut),
          Product(
              category: 'GROCERY',
              id: '04',
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'Lidl',
                steetNo: '2',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              price: 10,
              name: 'Red Bull Energy Drink',
              quantity: 1,
              availableStatus: AvailableStatus.unknown),
        ]),
    PurchaseDetails(
        id: '1',
        notificationType: NotificationType.shoppingNotification.notificationValue,
        listName: 'Weekly food',
        paymentOption: PaymentOption(
            title: 'Advance payment'
        ),
        storeDetails: StoreDataModel(
            steetNo: '2',
            image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
            name: 'REWE',
            landMark: 'Hinterdumpenhausen',
            street: 'Domstrasse 20 ',
            txtZip: '50668',
            city: 'Nürnberg',
            webSitUrl: 'https://www.rewe.de/',
            openingTime: '9:',
            closingTime: '22:'),
        amount: 350,
        customer: UserModel(
            name: 'Christina Beringer',
            street: 'Domstrasse 20 ',
            zipCode: '50668',
            city: 'Nürnberg',
            imageUrl:
                'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg'),
        quantity: 9,
        time: DateTime.now(),
        products: [
          Product(
              id: 'g1',
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 2,
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              category: 'GROCERY',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              price: 4,
              availableStatus: AvailableStatus.plenty,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g2',
              name: 'Semi Skimmed Milk',
              quantity: 5,
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              price: 4,
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g3',
              name: 'Organic Black Peppercorns',
              quantity: 1,
              imageUrl:
                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              price: 3,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'g4',
              name: 'Red Bull Energy Drink',
              quantity: 1,
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              category: 'GROCERY',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              price: 11,
              availableStatus: AvailableStatus.unknown,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
        ]),
    PurchaseDetails(
        listName: 'Household',
        paymentOption: PaymentOption(
            title: 'Advance payment'
        ),
        notificationType: NotificationType.shareNotification.notificationValue,
        storeDetails: StoreDataModel(
            steetNo: '2',
            image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
            name: 'Lidl',
            landMark: 'Hinterdupfing',
            street: 'Hauptstrasse 6a',
            city: 'Düsseldorf',
            txtZip: '56456',
            webSitUrl: 'https://www.rewe.de/',
            openingTime: '9:',
            closingTime: '22:'),
        amount: 4,
        customer: UserModel(
            name: 'Jakob Merz',
            street: 'Domstrasse 20 ',
            zipCode: '50668',
            city: 'Nürnberg',
            imageUrl:
                'https://ath2.unileverservices.com/wp-content/uploads/sites/8/2019/09/hairstyles-for-men-with-round-faces-side-part.jpg'),
        quantity: 9,
        time: DateTime.now(),
        products: [
          Product(
              category: 'GROCERY',
              id: '01',
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 2,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              )),
          Product(
            category: 'GROCERY',
            imageUrl:
                'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
            id: '02',
            storeDetails: StoreDataModel(
              name: 'Lidl',
              steetNo: '2',
              image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
              street: 'Hauptstrasse 6a',
              city: 'Düsseldorf',
              txtZip: '56456',
            ),
            name: 'Semi Skimmed Milk',
            price: 2,
            quantity: 5,
            availableStatus: AvailableStatus.plenty,
          ),
          Product(
              category: 'GROCERY',
              id: '03',
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'Lidl',
                steetNo: '2',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              name: 'Organic Black Peppercorns',
              quantity: 1,
              price: 2,
              availableStatus: AvailableStatus.runOut),
          Product(
              category: 'GROCERY',
              id: '04',
              imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                name: 'Lidl',
                steetNo: '2',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              price: 10,
              name: 'Red Bull Energy Drink',
              quantity: 1,
              availableStatus: AvailableStatus.unknown),
        ]),
  ];
  static List<StoreDataModel> storeList = [
    StoreDataModel(
      id: '1',
      steetNo: '2',
      name: 'REWE',
      street: 'Domstrasse 20 ',
      txtZip: '50668',
      city: 'Nürnberg',
      openingTime: '09:00',
      closingTime: '22:00',
      webSitUrl: 'https://www.figma.com/file/SRrTkXdntYxOo2HgtBvQWI/Store-Angels-App?node-id=306%3A0',
      image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
      topList: [
        UserModel(
            name: 'Vanessa Gantikow-Schröder',
            imageUrl:
            'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
          street: 'Hauptstrasse 6a',
          city: 'Düsseldorf',
          zipCode: '56456',),
        UserModel(
            id: 'qwerqwerqwer',
            name: 'Zeny Fisher',
            imageUrl: 'https://www.ddpch.com/wp-content/uploads/2020/04/89803.jpg',
            street: 'Hauptstrasse 6a',
            city: 'Düsseldorf',
            zipCode: '56456'),
      ]
    ),
    StoreDataModel(
      id: '2',
      steetNo: '2',
      name: 'LIDL an den Heidelsbergen',
      street: 'Hauptstrasse 6a',
      city: 'Düsseldorf',
      txtZip: '56456',
      openingTime: '09:00',
      closingTime: '22:00',
      webSitUrl: 'https://www.figma.com/file/SRrTkXdntYxOo2HgtBvQWI/Store-Angels-App?node-id=306%3A0',
      image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
        topList: [
          UserModel(
            name: 'Vanessa Gantikow-Schröder',
            imageUrl:
            'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
            street: 'Hauptstrasse 6a',
            city: 'Düsseldorf',
            zipCode: '56456',),
          UserModel(
              id: 'qwerqwerqwer',
              name: 'Zeny Fisher',
              imageUrl: 'https://www.ddpch.com/wp-content/uploads/2020/04/89803.jpg',
              street: 'Hauptstrasse 6a',
              city: 'Düsseldorf',
              zipCode: '56456'),
        ]
    ),
    StoreDataModel(
      topList: [
        UserModel(
          name: 'Vanessa Gantikow-Schröder',
          imageUrl:
          'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
          street: 'Hauptstrasse 6a',
          city: 'Düsseldorf',
          zipCode: '56456',),
        UserModel(
            id: 'qwerqwerqwer',
            name: 'Zeny Fisher',
            imageUrl: 'https://www.ddpch.com/wp-content/uploads/2020/04/89803.jpg',
            street: 'Hauptstrasse 6a',
            city: 'Düsseldorf',
            zipCode: '56456'),
      ],
      id: '3',
      steetNo: '2',
      street: '1200 N. Kirk Rd.',
      name: 'Aldi',
      city: 'Batavia',
      txtZip: '60510',
      openingTime: '09:00',
      closingTime: '22:00',
      webSitUrl: 'https://www.figma.com/file/SRrTkXdntYxOo2HgtBvQWI/Store-Angels-App?node-id=306%3A0',
      image:
          'https://www.supermarketnews.com/sites/supermarketnews.com/files/styles/article_featured_retina/public/Aldi_store-St_Charles_IL.jpg?itok=KEKzGOWh',
    ),
  ];

  static List<StoreDataModel> userSelectedStores = [];

// [
//   StoreDataModel(
//     id: '1',
//     name: 'REWE',
//     street: 'numbrecht Hauptstrable 12',
//     openingtime: '9:',
//     closingtime: '22:',
//     txtZip:'',
//     image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
//
//   ),
//   StoreDataModel(
//     id: '2',
//     name: 'LIDL',
//     street: 'numbrecht Hauptstrable 12',
//     openingtime: '9:',
//     closingtime: '22:',
//     txtZip:'',
//     image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
//   ),
//   StoreDataModel(
//     id: '3',
//     name: 'ALDI',
//     street: 'numbrecht Hauptstrable 12',
//     openingtime: '9:',
//     closingtime: '22:',
//     txtZip:'',
//     image: 'assets/images/sample_images/aldi.png',
//   )
// ];

  static List<OrderOrPurchases> orderList = [
    OrderOrPurchases(
      productName: 'White chocolate light',
      shopName: 'REWE',
      type: OrderAndPurchaseType.Order,
      orderAmount: 230,
      status: OrderPurchaseStatus.Pending,
      quantity: 11,
      clientDetails: ClientDetails(
        name: 'Jakob Merz',
        imageUrl: 'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
        street: 'Domstrasse 20 ',
        zip: '50668',
        city: 'Nürnberg',
      ),
      purchaseDetails: PurchaseDetails(

          paymentOption:
              PaymentOption(paymentOptionEnum: PaymentOptionEnum.prepayment, title: AppStrings.PREPAYMENT.tr()),
          listName: 'Household',
          notificationType: NotificationType.shareNotification.notificationValue,
          storeDetails: StoreDataModel(
              steetNo: '2',
              image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
              name: 'REWE',
              street: 'Domstrasse 20 ',
              txtZip: '50668',
              city: 'Nürnberg',
              openingTime: '9:',
              closingTime: '22:'),
          amount: 4,
          customer: UserModel(
              name: 'Jakob Merz',
              imageUrl:
                  'https://ath2.unileverservices.com/wp-content/uploads/sites/8/2019/09/hairstyles-for-men-with-round-faces-side-part.jpg'),
          quantity: 9,
          time: DateTime.now(),
          products: [
            Product(
                category: 'GROCERY',
                id: '01',
                name: 'Wagyu Beef Ribeye Steak',
                imageUrl:
                    'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 2,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
              category: 'GROCERY',
              id: '02',
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                name: 'REWE',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              ),
              name: 'Semi Skimmed Milk',
              price: 2,
              quantity: 5,
              availableStatus: AvailableStatus.plenty,
            ),
            Product(
                category: 'GROCERY',
                id: '03',
                imageUrl:
                    'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                name: 'Organic Black Peppercorns',
                quantity: 1,
                price: 2,
                availableStatus: AvailableStatus.runOut),
            Product(
                category: 'GROCERY',
                id: '04',
                imageUrl:
                    'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                price: 10,
                name: 'Red Bull Energy Drink',
                quantity: 1,
                availableStatus: AvailableStatus.unknown),
            Product(
                category: 'GROCERY',
                id: '01',
                name: 'Wagyu Beef Ribeye Steak',
                imageUrl:
                    'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 2,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
              category: 'GROCERY',
              id: '02',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                name: 'REWE',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              ),
              name: 'Semi Skimmed Milk',
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              price: 2,
              quantity: 5,
              availableStatus: AvailableStatus.plenty,
            ),
            Product(
                category: 'GROCERY',
                id: '03',
                imageUrl:
                    'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                name: 'Organic Black Peppercorns',
                quantity: 1,
                price: 2,
                availableStatus: AvailableStatus.runOut),
            Product(
                category: 'GROCERY',
                id: '04',
                imageUrl:
                    'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                price: 10,
                name: 'Red Bull Energy Drink',
                quantity: 1,
                availableStatus: AvailableStatus.unknown),
            Product(
                category: 'GROCERY',
                id: '01',
                name: 'Wagyu Beef Ribeye Steak',
                imageUrl:
                    'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 2,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
              category: 'GROCERY',
              id: '02',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                name: 'REWE',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              ),
              name: 'Semi Skimmed Milk',
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              price: 2,
              quantity: 5,
              availableStatus: AvailableStatus.plenty,
            ),
            Product(
                category: 'GROCERY',
                id: '03',
                imageUrl:
                    'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                name: 'Organic Black Peppercorns',
                quantity: 1,
                price: 2,
                availableStatus: AvailableStatus.runOut),
            Product(
                category: 'GROCERY',
                id: '04',
                imageUrl:
                    'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                price: 10,
                name: 'Red Bull Energy Drink',
                quantity: 1,
                availableStatus: AvailableStatus.unknown),
          ]),
      candidates: [ CourierCandidate(
        name: 'Vanessa Gantikow-Schröder',
        stars: 3,
        verifyStatus: VerifyStatus.Reliable,
        reliable: true,
        approved: true,
        insured: true,
        favourite: true,
        charge: 10,
        reviews: 12,
        time: '1 hours ago',
        imageUrl:
        'https://images.unsplash.com/photo-1563122870-6b0b48a0af09?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmxhY2slMjBtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
        status: 'Updated',
      ),CourierCandidate(
        reviews: 10,
        charge: 12,
        name: 'Vanessa Gantikow-Schröder',
        stars: 3,
        verifyStatus: VerifyStatus.Reliable,
        time: '1 hours ago',
        imageUrl:
        'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
        status: 'Updated',
      )],
      proposalDetails: ProposalDetails(
          totalProposals: 10, unseenProposal: 7, time: DateTime.now().subtract(new Duration(minutes: 10))),
    ),
    OrderOrPurchases(
      type: OrderAndPurchaseType.Order,
      productName: 'White chocolate light',
      shopName: 'Lidl',
      orderAmount: 130,
      clientDetails: ClientDetails(
        name: 'Jakob Merz',
        imageUrl: 'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
        street: 'Domstrasse 20 ',
        zip: '50668',
        city: 'Nürnberg',
      ),
      status: OrderPurchaseStatus.Finished,
      quantity: 5,
      purchaseDetails: PurchaseDetails(
          paymentOption:
              PaymentOption(title: AppStrings.NO_PREFERENCES.tr(), paymentOptionEnum: PaymentOptionEnum.prepayment),
          listName: 'Household',
          notificationType: NotificationType.shareNotification.notificationValue,
          storeDetails: StoreDataModel(
              steetNo: '2',
              image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
              name: 'Lidl',
              street: 'Hauptstrasse 6a',
              city: 'Düsseldorf',
              txtZip: '56456',
              openingTime: '9:',
              closingTime: '22:'),
          amount: 4,
          customer: UserModel(
              name: 'Jakob Merz',
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/sample_profile.png?alt=media&token=5bbcd983-45aa-4c98-8487-1b8a79650ac7'),
          quantity: 9,
          time: DateTime.now(),
          products: [
            Product(
                category: 'GROCERY',
                id: '01',
                imageUrl:
                    'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                name: 'Wagyu Beef Ribeye Steak',
                quantity: 2,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'Lidl',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                )),
            Product(
              category: 'GROCERY',
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              id: '02',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              name: 'Semi Skimmed Milk',
              price: 2,
              quantity: 5,
              availableStatus: AvailableStatus.plenty,
            ),
            Product(
                category: 'GROCERY',
                imageUrl:
                    'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                id: '03',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  name: 'Lidl',
                  steetNo: '2',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                ),
                name: 'Organic Black Peppercorns',
                quantity: 1,
                price: 2,
                availableStatus: AvailableStatus.runOut),
            Product(
                category: 'GROCERY',
                id: '04',
                imageUrl:
                    'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'Lidl',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                ),
                price: 10,
                name: 'Red Bull Energy Drink',
                quantity: 1,
                availableStatus: AvailableStatus.unknown),
            Product(
                category: 'GROCERY',
                id: '01',
                imageUrl:
                    'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                name: 'Wagyu Beef Ribeye Steak',
                quantity: 2,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  name: 'Lidl',
                  steetNo: '2',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                )),
            Product(
              category: 'GROCERY',
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              id: '02',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              name: 'Semi Skimmed Milk',
              price: 2,
              quantity: 5,
              availableStatus: AvailableStatus.plenty,
            ),
            Product(
                category: 'GROCERY',
                imageUrl:
                    'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                id: '03',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'Lidl',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                ),
                name: 'Organic Black Peppercorns',
                quantity: 1,
                price: 2,
                availableStatus: AvailableStatus.runOut),
            Product(
                category: 'GROCERY',
                id: '04',
                imageUrl:
                    'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'Lidl',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                ),
                price: 10,
                name: 'Red Bull Energy Drink',
                quantity: 1,
                availableStatus: AvailableStatus.unknown),
          ]),
      proposalDetails: ProposalDetails(
          totalProposals: 9, unseenProposal: 5, time: DateTime.now().subtract(new Duration(minutes: 15))),
      candidates: [
        CourierCandidate(
        name: 'Vanessa Gantikow-Schröder',
        stars: 3,
        verifyStatus: VerifyStatus.Reliable,
        reliable: true,
        approved: true,
        insured: true,
          favourite: true,
        charge: 10,
        reviews: 12,
        time: '1 hours ago',
        imageUrl:
            'https://images.unsplash.com/photo-1563122870-6b0b48a0af09?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmxhY2slMjBtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
        status: 'Updated',
      ),CourierCandidate(
        reviews: 10,
        charge: 12,
        name: 'Vanessa Gantikow-Schröder',
        stars: 3,
        verifyStatus: VerifyStatus.Reliable,
        time: '1 hours ago',
        imageUrl:
        'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
        status: 'Updated',
      )],
    ),
    OrderOrPurchases(
        type: OrderAndPurchaseType.Order,
        productName: 'White chocolate light',
        shopName: 'Lidl',
        orderAmount: 130,
        status: OrderPurchaseStatus.MoneyTransfer,
        quantity: 5,
        clientDetails: ClientDetails(
  name: 'Jakob Merz',
  imageUrl:
  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/sample_profile.png?alt=media&token=5bbcd983-45aa-4c98-8487-1b8a79650ac7'
        ),


        proposalDetails: ProposalDetails(
            totalProposals: 9, unseenProposal: 5, time: DateTime.now().subtract(new Duration(minutes: 15))),
        candidates: [ CourierCandidate(
          name: 'Vanessa Gantikow-Schröder',
          stars: 3,
          verifyStatus: VerifyStatus.Reliable,
          reliable: true,
          approved: true,
          insured: true,
          favourite: true,
          charge: 10,
          reviews: 12,
          time: '1 hours ago',
          imageUrl:
          'https://images.unsplash.com/photo-1563122870-6b0b48a0af09?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmxhY2slMjBtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
          status: 'Updated',
        ),CourierCandidate(
          reviews: 10,
          charge: 12,
          name: 'Vanessa Gantikow-Schröder',
          stars: 3,
          verifyStatus: VerifyStatus.Reliable,
          time: '1 hours ago',
          imageUrl:
          'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
          status: 'Updated',
        )],
        purchaseDetails: PurchaseDetails(
            listName: 'Household',
            notificationType: NotificationType.shareNotification.notificationValue,
            paymentOption: PaymentOption(
                title: AppStrings.PAYMENT_ON_DELIVERY.tr(), paymentOptionEnum: PaymentOptionEnum.prepayment),
            storeDetails: StoreDataModel(
                steetNo: '2',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                name: 'Lidl',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
                openingTime: '9:',
                closingTime: '22:'),
            amount: 4,
            customer: UserModel(
                name: 'Jakob Merz',
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/sample_profile.png?alt=media&token=5bbcd983-45aa-4c98-8487-1b8a79650ac7'),
            quantity: 9,
            time: DateTime.now(),

            products: [
              Product(
                  category: 'GROCERY',
                  imageUrl:
                      'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                  id: '01',
                  name: 'Wagyu Beef Ribeye Steak',
                  quantity: 2,
                  price: 2,
                  createdBy: UserModel(
                      name: 'Vanessa Gantikow-Schröder',
                      imageUrl:
                          'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                  availableStatus: AvailableStatus.few,
                  storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'Lidl',
                    image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                    street: 'Hauptstrasse 6a',
                    city: 'Düsseldorf',
                    txtZip: '56456',
                  )),
              Product(
                category: 'GROCERY',
                id: '02',
                imageUrl:
                    'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  name: 'Lidl',
                  steetNo: '2',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                ),
                name: 'Semi Skimmed Milk',
                price: 2,
                quantity: 5,
                availableStatus: AvailableStatus.plenty,
              ),

              Product(
                  category: 'GROCERY',
                  id: '03',
                  imageUrl:
                      'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                  createdBy: UserModel(
                      name: 'Vanessa Gantikow-Schröder',
                      imageUrl:
                          'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                  storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'Lidl',
                    image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                    street: 'Hauptstrasse 6a',
                    city: 'Düsseldorf',
                    txtZip: '56456',
                  ),
                  name: 'Organic Black Peppercorns',
                  quantity: 1,
                  price: 2,
                  availableStatus: AvailableStatus.runOut),
              Product(
                  category: 'GROCERY',
                  id: '04',
                  imageUrl:
                      'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                  createdBy: UserModel(
                      name: 'Vanessa Gantikow-Schröder',
                      imageUrl:
                          'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                  storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'Lidl',
                    image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                    street: 'Hauptstrasse 6a',
                    city: 'Düsseldorf',
                    txtZip: '56456',
                  ),
                  price: 10,
                  name: 'Red Bull Energy Drink',
                  quantity: 1,
                  availableStatus: AvailableStatus.unknown),
            ])),
    OrderOrPurchases(
        type: OrderAndPurchaseType.Order,
        productName: 'White chocolate light',
        shopName: 'Lidl',
        orderAmount: 130,
        clientDetails: ClientDetails(
          name: 'Jakob Merz',
          imageUrl: 'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
          street: 'Domstrasse 20 ',
          zip: '50668',
          city: 'Nürnberg',
        ),
        status: OrderPurchaseStatus.Finished,
        quantity: 5,
        proposalDetails: ProposalDetails(
            totalProposals: 9, unseenProposal: 5, time: DateTime.now().subtract(new Duration(minutes: 15))),
        candidates:[ CourierCandidate(
          name: 'ack Fisher',
          stars: 4,
          verifyStatus: VerifyStatus.Reliable,
          time: '1 hours ago',
          imageUrl:
              'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
          status: 'Updated',
        ),
          CourierCandidate(
            name: 'Vanessa Gantikow-Schröder',
            stars: 3,
            verifyStatus: VerifyStatus.Reliable,
            reliable: true,
            approved: true,
            insured: true,
            charge: 10,
            reviews: 12,
            time: '1 hours ago',
            imageUrl:
            'https://images.unsplash.com/photo-1563122870-6b0b48a0af09?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmxhY2slMjBtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
            status: 'Updated',
          ),CourierCandidate(
            reviews: 10,
            charge: 12,
            name: 'Vanessa Gantikow-Schröder',
            stars: 3,
            verifyStatus: VerifyStatus.Reliable,
            time: '1 hours ago',
            imageUrl:
            'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
            status: 'Updated',
          )],
        purchaseDetails: PurchaseDetails(
            paymentOption: PaymentOption(
                title: AppStrings.PAYMENT_ON_DELIVERY.tr(), paymentOptionEnum: PaymentOptionEnum.prepayment),
            listName: 'Household',
            notificationType: NotificationType.shareNotification.notificationValue,
            storeDetails: StoreDataModel(
                steetNo: '2',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                name: 'Lidl',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
                openingTime: '9:',
                closingTime: '22:'),
            amount: 4,
            customer: UserModel(
                name: 'Jakob Merz',
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/sample_profile.png?alt=media&token=5bbcd983-45aa-4c98-8487-1b8a79650ac7'),
            quantity: 9,
            time: DateTime.now(),
            products: [
              Product(
                  category: 'GROCERY',
                  imageUrl:
                      'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                  id: '01',
                  name: 'Wagyu Beef Ribeye Steak',
                  quantity: 2,
                  price: 2,
                  createdBy: UserModel(
                      name: 'Vanessa Gantikow-Schröder',
                      imageUrl:
                          'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                  availableStatus: AvailableStatus.few,
                  storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'Lidl',
                    image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                    street: 'Hauptstrasse 6a',
                    city: 'Düsseldorf',
                    txtZip: '56456',
                  )),
              Product(
                category: 'GROCERY',
                id: '02',
                imageUrl:
                    'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'Lidl',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                ),
                name: 'Semi Skimmed Milk',
                price: 2,
                quantity: 5,
                availableStatus: AvailableStatus.plenty,
              ),
              Product(
                  category: 'GROCERY',
                  id: '03',
                  imageUrl:
                      'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                  createdBy: UserModel(
                      name: 'Vanessa Gantikow-Schröder',
                      imageUrl:
                          'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                  storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'Lidl',
                    image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                    street: 'Hauptstrasse 6a',
                    city: 'Düsseldorf',
                    txtZip: '56456',
                  ),
                  name: 'Organic Black Peppercorns',
                  quantity: 1,
                  price: 2,
                  availableStatus: AvailableStatus.runOut),
              Product(
                  category: 'GROCERY',
                  id: '04',
                  imageUrl:
                      'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                  createdBy: UserModel(
                      name: 'Vanessa Gantikow-Schröder',
                      imageUrl:
                          'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                  storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'Lidl',
                    image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                    street: 'Hauptstrasse 6a',
                    city: 'Düsseldorf',
                    txtZip: '56456',
                  ),
                  price: 10,
                  name: 'Red Bull Energy Drink',
                  quantity: 1,
                  availableStatus: AvailableStatus.unknown),
            ])),
  ];
  static List<AddressModel> userAddresses = [
    AddressModel(
        name: 'Lisa Müller',
        street: 'Dunnheimerstraße 3a',
        city: 'Dusseidorf',
        zipCode: '84372',
        state: 'Nordrhein-Westfalen',
        country: 'Germany'),
    AddressModel(
        street: 'Dunnheimerstraße 2a',
        city: 'Dusseidorf',
        zipCode: '84372',
        state: 'Nordrhein-Westfalen',
        name: 'Annetgrett Hildenhammer',
        country: 'Germany')
  ];

  static List<OrderOrPurchases> courierOrders = [
    OrderOrPurchases(
        orderID: 'asdfasdf',
        paid: false,
        selectedDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
        paymentMethod: 'PayPal',
        deliveredAt: DateTime.now(),
        postedAt: DateTime.now().subtract(Duration(hours: 2)),
        timeDuration: '17:00 - 20:00',
        status: OrderPurchaseStatus.MoneyTransfer,
        comment: 'When you deliver, please do not ring the bell. My baby can sleep. Just call me and I’ll meet you.',
        orderAmount: 230,
        orderPayment: 'Prepayment',
        purchaseDetails: PurchaseDetails(
          paymentOption: PaymentOption(paymentOptionEnum: PaymentOptionEnum.payment_on_delivery),
          products: [
            Product(
                id: 'sadfsdf',
                name: 'Wagyu Beef Ribeye Steak',
                imageUrl:
                    'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                price: 3,
                availableStatus: AvailableStatus.plenty,
                storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'REWE',
                    image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                    city: 'Nürnberg',
                    txtZip: '93432',
                    street: 'Hauptstrasse 12')),
            Product(
                id: 'sadfasqsdf',
                name: 'Semi Skimmed Milk',
                imageUrl:
                    'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 10,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                id: 'sadfyxaxsdf',
                name: 'Orangic Black Peppercorns',
                quantity: 1,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                availableStatus: AvailableStatus.runOut,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                id: 'sadfsvvevedf',
                name: 'Red Bull Energy Drink',
                quantity: 1,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),

                /////
                imageUrl:
                    'https://i5.walmartimages.com/asr/7c19969c-d5be-4351-9061-54e00a6320c8_1.cf68e0ecc361dba9d1d5cf9730ede7fa.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                availableStatus: AvailableStatus.unknown,
                storeDetails: StoreDataModel(
                  name: 'REWE',
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                id: 'sadfsdxsf',
                name: 'Mizani 25 Miracle Milk leave',
                quantity: 2,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://i5.walmartimages.com/asr/c95d86a3-43de-4a29-b887-696c4b2f7ff7_1.7d76071a15118dad24256c201aebd915.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                id: 'sadewfsdf',
                name: 'Great Value Original Soymilk',
                quantity: 10,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://i5.walmartimages.com/asr/5b27d3f9-1fcc-4300-b96b-ae576f6d184b_2.7999df8a262568356848e28ed7009150.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                availableStatus: AvailableStatus.runOut,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                id: 'sadqwfsdf',
                name: 'Short-grain rice',
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://i5.walmartimages.com/asr/1d85298d-3334-4ed3-8fe9-b6e2a9954076_1.7da524438875fb3e3089e9cc361ff3ac.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                availableStatus: AvailableStatus.plenty,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
              id: 'sadfesdf',
              name: 'Organic Black Peppercorns',
              quantity: 1,
              price: 5,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.plenty,
            ),
          ],
        ),
        clientDetails: ClientDetails(
            streetNo: '3',
            name: 'John Flores',
            street: 'Knesebeckstrasse 76',
            city: 'Nürnberg',
            zip: '92323',
            imageUrl:
                'https://ath2.unileverservices.com/wp-content/uploads/sites/8/2019/09/hairstyles-for-men-with-round-faces-side-part.jpg'),
        candidates: candidatesList,
        clientlist: [
          UserModel(
              id: 'asdfsdfdsf',
              name: 'Vanessa Gantikow-Schröder',
              street: 'Mondblumenstraße 4',
              city: 'Feenstadt',
              zipCode: '89456',
              imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
          UserModel(
              id: 'qwerqwerqwer',
              name: 'Zeny Fisher',
              imageUrl: 'https://www.ddpch.com/wp-content/uploads/2020/04/89803.jpg'),
          UserModel(
              id: 'weörjqwerjöqwkerj',
              name: 'Emma Fisher',
              imageUrl:
                  'https://elements-video-cover-images-0.imgix.net/files/57f64821-c5df-4f31-b194-6226ffd7cb3d/inline_image_preview.jpg?auto=compress&crop=edges&fit=crop&fm=jpeg&h=800&w=1200&s=df032e394df4c7dc78be2ce26d1caf33'),
        ],
        storeDetails: StoreDataModel(
          steetNo: '2',
          name: 'REWE',
          id: 'asdfökasdjöf',
          image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
          street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',
        ),
        quantity: 10,
        alreadyDone: 1),
    OrderOrPurchases(
        orderID: 'asdfasdf',
        paid: true,
        selectedDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
        timeDuration: '17:00 - 20:00',
        status: OrderPurchaseStatus.Proposal,
        postedAt: DateTime.now().subtract(Duration(hours: 2)),
        comment: 'When you deliver, please do not ring the bell. My baby can sleep. Just call me and I’ll meet you.',
        orderAmount: 140,
        candidates: candidatesList,
        deliveredAt: DateTime.now(),
        purchaseDetails: PurchaseDetails(
          products: [
            Product(
                id: 'sadfsdf',
                name: 'Wagyu Beef Ribeye Steak',
                imageUrl:
                    'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                price: 3,
                availableStatus: AvailableStatus.plenty,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                id: 'sadfasqsdf',
                name: 'Semi Skimmed Milk',
                imageUrl:
                    'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 10,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                id: 'sadfyxaxsdf',
                name: 'Orangic Black Peppercorns',
                quantity: 1,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://i5.walmartimages.com/asr/dd80f1d3-6347-4cff-a3f5-89333367f804.c16c18b1bf6febd8fc208e4033d59e15.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                availableStatus: AvailableStatus.runOut,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                id: 'sadfsvvevedf',
                name: 'Red Bull Energy Drink',
                quantity: 1,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://i5.walmartimages.com/asr/7c19969c-d5be-4351-9061-54e00a6320c8_1.cf68e0ecc361dba9d1d5cf9730ede7fa.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                availableStatus: AvailableStatus.unknown,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
          ],
          paymentOption: PaymentOption(paymentOptionEnum: PaymentOptionEnum.prepayment),
        ),
        orderPayment: 'Prepayment',
        clientDetails: ClientDetails(
            streetNo: '3',
            name: 'Smrith',
            street: 'Knesebeckstrasse 76',
            city: 'Nürnberg',
            zip: '92323',
            imageUrl:
                'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
        clientlist: [
          UserModel(
              id: 'asdfsdfdsf',
              name: 'Vanessa Gantikow-Schröder',
              street: 'Mondblumenstraße 4',
              city: 'Feenstadt',
              zipCode: '89456',
              imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
          UserModel(
              id: 'qwerqwerqwer',
              name: 'Zeny Fisher',
              imageUrl: 'https://www.ddpch.com/wp-content/uploads/2020/04/89803.jpg'),
          UserModel(
              id: 'weörjqwerjöqwkerj',
              name: 'Emma Fisher',
              imageUrl:
                  'https://elements-video-cover-images-0.imgix.net/files/57f64821-c5df-4f31-b194-6226ffd7cb3d/inline_image_preview.jpg?auto=compress&crop=edges&fit=crop&fm=jpeg&h=800&w=1200&s=df032e394df4c7dc78be2ce26d1caf33'),
        ],
        storeDetails: StoreDataModel(
          steetNo: '2',
          name: 'REWE',
          id: 'asdfökasdjöf',
          image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
          street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',
        ),
        quantity: 10,
        alreadyDone: 1),
  ];

  static List<OrderOrPurchases> asignCourierOrder = <OrderOrPurchases>[
    OrderOrPurchases(
        orderID: 'asdfasdf',
        paid: false,
        selectedDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
        paymentMethod: 'PayPal',
        deliveredAt: DateTime.now(),
        postedAt: DateTime.now().subtract(Duration(hours: 2)),
        timeDuration: '17:00 - 20:00',
        status: OrderPurchaseStatus.Proposal,
        comment: 'When you deliver, please do not ring the bell. My baby can sleep. Just call me and I’ll meet you.',
        orderAmount: 230,
        orderPayment: 'Prepayment',
        purchaseDetails: PurchaseDetails(
          customer: UserModel(
            name: 'Bereit zum Einkauf',
            imageUrl: 'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'

          ),
          paymentOption: purchaseDetails.paymentOption,
          products: [
            Product(
                id: 'sadfsdf',
                name: 'Wagyu Beef Ribeye Steak',
                imageUrl:
                    'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                price: 3,
                availableStatus: AvailableStatus.plenty,
                storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'REWE',
                    image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                    city: 'Nürnberg',
                    txtZip: '93432',
                    street: 'Hauptstrasse 12')),
            Product(
                id: 'sadfasqsdf',
                name: 'Semi Skimmed Milk',
                imageUrl:
                    'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 10,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                id: 'sadfyxaxsdf',
                name: 'Orangic Black Peppercorns',
                quantity: 1,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://i5.walmartimages.com/asr/dd80f1d3-6347-4cff-a3f5-89333367f804.c16c18b1bf6febd8fc208e4033d59e15.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                availableStatus: AvailableStatus.runOut,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                id: 'sadfsvvevedf',
                name: 'Red Bull Energy Drink',
                quantity: 1,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://i5.walmartimages.com/asr/7c19969c-d5be-4351-9061-54e00a6320c8_1.cf68e0ecc361dba9d1d5cf9730ede7fa.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                availableStatus: AvailableStatus.unknown,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                id: 'sadfsdxsf',
                name: 'Mizani 25 Miracle Milk leave',
                quantity: 2,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://i5.walmartimages.com/asr/c95d86a3-43de-4a29-b887-696c4b2f7ff7_1.7d76071a15118dad24256c201aebd915.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                id: 'sadewfsdf',
                name: 'Great Value Original Soymilk',
                quantity: 10,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://i5.walmartimages.com/asr/5b27d3f9-1fcc-4300-b96b-ae576f6d184b_2.7999df8a262568356848e28ed7009150.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                availableStatus: AvailableStatus.runOut,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                id: 'sadqwfsdf',
                name: 'Short-grain rice',
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://i5.walmartimages.com/asr/c95d86a3-43de-4a29-b887-696c4b2f7ff7_1.7d76071a15118dad24256c201aebd915.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                availableStatus: AvailableStatus.plenty,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'REWE',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
              id: 'sadrfsdf',
              name: 'Organic Black Peppercorns',
              quantity: 1,
              price: 5,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.plenty,
            ),
            Product(
              id: 'sadfesdf',
              name: 'Organic Black Peppercorns',
              quantity: 1,
              price: 5,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.plenty,
            ),
            Product(
              id: 'sadfdsdf',
              name: 'Organic Black Peppercorns',
              quantity: 1,
              price: 5,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.plenty,
            ),
          ],
        ),
        clientDetails: ClientDetails(
            streetNo: '3',
            name: 'John Flores',
            street: 'Knesebeckstrasse 76',
            city: 'Nürnberg',
            zip: '92323',
            imageUrl:
                'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
        candidates: candidatesList,
        clientlist: [
          UserModel(
              id: 'asdfsdfdsf',
              name: 'Vanessa Gantikow-Schröder',
              street: 'Mondblumenstraße 4',
              city: 'Feenstadt',
              zipCode: '89456',
              imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
          UserModel(
              id: 'qwerqwerqwer',
              name: 'Vanessa Gantikow-Schröder',
              imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
          UserModel(
              id: 'weörjqwerjöqwkerj',
              name: 'Vanessa Gantikow-Schröder',
              imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
        ],
        storeDetails: StoreDataModel(
          steetNo: '2',
          name: 'REWE',
          id: 'asdfökasdjöf',
          image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
          street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',
        ),
        quantity: 10,
        alreadyDone: 1),
    OrderOrPurchases(
        orderID: 'asdfasdf',
        paid: true,
        selectedDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
        timeDuration: '17:00 - 20:00',
        status: OrderPurchaseStatus.Proposal,
        comment: 'When you deliver, please do not ring the bell. My baby can sleep. Just call me and I’ll meet you.',
        orderAmount: 140,
        deliveredAt: DateTime.now(),
        purchaseDetails: PurchaseDetails(
            customer: UserModel(
                name: 'Bereit zum Einkauf',
                imageUrl: 'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'

            ),
            products: [
          Product(
              id: 'sadfsdf',
              name: 'Wagyu Beef Ribeye Steak',
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              quantity: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              price: 3,
              availableStatus: AvailableStatus.plenty,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'sadfasqsdf',
              name: 'Semi Skimmed Milk',
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              quantity: 10,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'sadfyxaxsdf',
              name: 'Orangic Black Peppercorns',
              quantity: 1,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/dd80f1d3-6347-4cff-a3f5-89333367f804.c16c18b1bf6febd8fc208e4033d59e15.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'sadfsvvevedf',
              name: 'Red Bull Energy Drink',
              quantity: 1,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://i5.walmartimages.com/asr/7c19969c-d5be-4351-9061-54e00a6320c8_1.cf68e0ecc361dba9d1d5cf9730ede7fa.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.unknown,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
        ], paymentOption: purchaseDetails.paymentOption),
        orderPayment: 'Payment on delivery',
        clientDetails: ClientDetails(
            streetNo: '3',
            name: 'Smrith',
            street: 'Knesebeckstrasse 76',
            city: 'Nürnberg',
            zip: '92323',
            imageUrl:
                'https://enlightenedwomen.org/wp-content/uploads/2018/02/CDT-headshot-1024x1024.jpg'),
        clientlist: [
          UserModel(
              id: 'asdfsdfdsf',
              name: 'Vanessa Gantikow-Schröder',
              imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
          UserModel(
              id: 'qwerqwerqwer',
              name: 'Vanessa Gantikow-Schröder',
              imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
          UserModel(
              id: 'weörjqwerjöqwkerj',
              name: 'Vanessa Gantikow-Schröder',
              imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
        ],
        storeDetails: StoreDataModel(
          name: 'REWE',
          id: 'asdfökasdjöf',
          steetNo: '2',
          image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
          street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',
        ),
        quantity: 10,
        alreadyDone: 1),

  ];

  static UserModel currentUserModel = UserModel(
      street: 'Hauptstraße 12',
      city: 'Numberg',
      name: 'Carlos San Diago',
      id: 'wekfjawkelfjökwefjawkelfjjweklf',
      imageUrl:
          'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
      userType: 'Consumer',
      status: ShareStatus.Unknown,
      firstName: 'Ferdinand',
      lastName: 'Kollega',
      verify: 2,
      zipCode: '92323',
      addressLine: 'Long line');

  static List prePaidPaymentMethods = [
    {'imageUrl': AssetsPath.paypal, "title": "PayPal"},
//    {'imageUrl': AssetsPath.amazon_pay, "title": AppPaymentMethods.amazonPay},
    {'imageUrl': AssetsPath.googleLogo, "title": AppPaymentMethods.googlePay},
    {'imageUrl': AssetsPath.applePay, "title": AppPaymentMethods.applePay},
    {'imageUrl': AssetsPath.sofortueberweisung, "title": AppPaymentMethods.sofortPay},
    {'imageUrl': AssetsPath.creditCard, "title": AppPaymentMethods.cardPay},
  ];

  static List paymentMethods = [
    {'imageUrl': AssetsPath.paypal, "title": "PayPal"},
//    {'imageUrl': AssetsPath.amazon_pay, "title": AppPaymentMethods.amazonPay},
    {'imageUrl': AssetsPath.googleLogo, "title": AppPaymentMethods.googlePay},
    {'imageUrl': AssetsPath.applePay, "title": AppPaymentMethods.applePay},
    {'imageUrl': AssetsPath.sofortueberweisung, "title": AppPaymentMethods.sofortPay},
    {'imageUrl': AssetsPath.creditCard, "title": AppPaymentMethods.cardPay},
    {'imageUrl': AssetsPath.money, "title": "Cash on Delivery"}
  ];

  static PurchaseDetails purchaseDetails = PurchaseDetails(
      id: '1',
      paymentOption: PaymentOption(paymentOptionEnum: PaymentOptionEnum.prepayment),
      notificationType: NotificationType.shoppingNotification.notificationValue,
      listName: 'Weekly food',
      storeDetails: StoreDataModel(
          image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
          name: 'REWE',
          steetNo: '2',
          street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',
          openingTime: '9:00',
          closingTime: '22:00'),
      amount: 350,
      customer: UserModel(
          name: 'Jakob Merz',
          imageUrl:
              'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/sample_profile.png?alt=media&token=5bbcd983-45aa-4c98-8487-1b8a79650ac7'),
      quantity: 9,
      time: DateTime.now(),
      products: [
        Product(
            category: 'GROCERY',
            imageUrl:
                'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
            id: 'g1',
            name: 'Wagyu Beef Ribeye Steak',
            quantity: 2,
            price: 4,
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
            availableStatus: AvailableStatus.plenty,
            storeDetails: StoreDataModel(
              name: 'REWE',
              steetNo: '2',
              image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
              street: 'Domstrasse 20 ',
              txtZip: '50668',
              city: 'Nürnberg',
            )),
        Product(
            category: 'GROCERY',
            id: 'g2',
            imageUrl:
                'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
            name: 'Semi Skimmed Milk',
            quantity: 5,
            price: 4,
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
            availableStatus: AvailableStatus.few,
            storeDetails: StoreDataModel(
              name: 'REWE',
              steetNo: '2',
              image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
              street: 'Domstrasse 20 ',
              txtZip: '50668',
              city: 'Nürnberg',
            )),
        Product(
            category: 'GROCERY',
            id: 'g3',
            imageUrl:
                'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
            name: 'Organic Black Peppercorns',
            quantity: 1,
            price: 3,
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
            availableStatus: AvailableStatus.runOut,
            storeDetails: StoreDataModel(
              name: 'REWE',
              steetNo: '2',
              image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
              street: 'Domstrasse 20 ',
              txtZip: '50668',
              city: 'Nürnberg',
            )),
        Product(
            category: 'GROCERY',
            id: 'g4',
            imageUrl:
                'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
            name: 'Red Bull Energy Drink',
            quantity: 1,
            price: 11,
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
            availableStatus: AvailableStatus.unknown,
            storeDetails: StoreDataModel(
              name: 'REWE',
              steetNo: '2',
              image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
              street: 'Domstrasse 20 ',
              txtZip: '50668',
              city: 'Nürnberg',
            )),
      ]);

  static List<ChatMessage> chatMessages = [

    ChatMessage(
        sendBy: UserModel(id: 'a'),
        message:
            'Die Bio Birnen sind aus. Soll ich Ihnen normale kaufen?',
        createdAt: DateTime(2020, 9, 2, 16, 55)),
    ChatMessage(
        message:
            "Ja bitte!",
        sendBy: UserModel(id: 'b'),
        createdAt: DateTime(2020, 9, 2, 14,
            44)), /*
    ChatMessage(
        message: "Hey, I have heared that there could be some problem with the payment. Do you know something about this? If you want to I could help you trigger the payment. This should be absolutly no problem for me.",
        sendBy: UserModel(
            id: 'b'
        ),
        createdAt:DateTime(2020,9,2,16,44)
    ),
    ChatMessage(
        message: 'Yeah a little help would be awesome!',
        sendBy: UserModel(
            id: 'a'
        ),
        createdAt:DateTime(2020,9,2,16,50)
    ),
    ChatMessage(
      message: 'Sure tell me exactly what you are doing.',
      createdAt: DateTime(2020,9,2,16,56),
      sendBy: UserModel(
          id: 'b'
      ),
    ),
    ChatMessage(
        sendBy: UserModel(
            id: 'a'
        ),

        message: 'You simply need to push the button and move to the top of the screen. Then you are able to see all payments and are also able to accept them if you need some more help. It’s really not complicated. Try to get to this point and you can fix your issue with no problem.'
        ,createdAt: DateTime(2020,9,2,16,55)),
    ChatMessage(
        message: "Somehow I can't transfer to your account. Do you know why it that. Is there  some way of restriction?",
        sendBy: UserModel(
            id: 'a'
        ),
        createdAt:DateTime(2020,9,2,14,44)
    ),
    ChatMessage(
        message: "Hey, I have heared that there could be some problem with the payment. Do you know something about this? If you want to I could help you trigger the payment. This should be absolutly no problem for me.",
        sendBy: UserModel(
            id: 'b'
        ),
        createdAt:DateTime(2020,9,2,16,44)
    ),
    ChatMessage(
        message: 'Yeah a little help would be awesome!',
        sendBy: UserModel(
            id: 'a'
        ),
        createdAt:DateTime(2020,9,2,16,50)
    ),
    ChatMessage(
      message: 'Sure tell me exactly what you are doing.',
      createdAt: DateTime(2020,9,2,16,56),
      sendBy: UserModel(
          id: 'b'
      ),
    ),
    ChatMessage(
        sendBy: UserModel(
            id: 'a'
        ),

        message: 'You simply need to push the button and move to the top of the screen. Then you are able to see all payments and are also able to accept them if you need some more help. It’s really not complicated. Try to get to this point and you can fix your issue with no problem.'
        ,createdAt: DateTime(2020,9,2,16,55)),
    ChatMessage(
        message: "Somehow I can't transfer to your account. Do you know why it that. Is there  some way of restriction?",
        sendBy: UserModel(
            id: 'a'
        ),
        createdAt:DateTime(2020,9,2,14,44)
    ),
    ChatMessage(
        message: "Hey, I have heared that there could be some problem with the payment. Do you know something about this? If you want to I could help you trigger the payment. This should be absolutly no problem for me.",
        sendBy: UserModel(
            id: 'b'
        ),
        createdAt:DateTime(2020,9,2,16,44)
    ),
    ChatMessage(
        message: 'Yeah a little help would be awesome!',
        sendBy: UserModel(
            id: 'a'
        ),
        createdAt:DateTime(2020,9,2,16,50)
    ),
    ChatMessage(
      message: 'Sure tell me exactly what you are doing.',
      createdAt: DateTime(2020,9,2,16,56),
      sendBy: UserModel(
          id: 'b'
      ),
    ),
    ChatMessage(
        sendBy: UserModel(
            id: 'a'
        ),

        message: 'You simply need to push the button and move to the top of the screen. Then you are able to see all payments and are also able to accept them if you need some more help. It’s really not complicated. Try to get to this point and you can fix your issue with no problem.'
        ,createdAt: DateTime(2020,9,2,16,55)),
    ChatMessage(
        message: "Somehow I can't transfer to your account. Do you know why it that. Is there  some way of restriction?",
        sendBy: UserModel(
            id: 'a'
        ),
        createdAt:DateTime(2020,9,2,14,44)
    ),
    ChatMessage(
        message: "Hey, I have heared that there could be some problem with the payment. Do you know something about this? If you want to I could help you trigger the payment. This should be absolutly no problem for me.",
        sendBy: UserModel(
            id: 'b'
        ),
        createdAt:DateTime(2020,9,2,16,44)
    ),
    ChatMessage(
        message: 'Yeah a little help would be awesome!',
        sendBy: UserModel(
            id: 'a'
        ),
        createdAt:DateTime(2020,9,2,16,50)
    ),
    ChatMessage(
      message: 'Sure tell me exactly what you are doing.',
      createdAt: DateTime(2020,9,2,16,56),
      sendBy: UserModel(
          id: 'b'
      ),
    ),
    ChatMessage(
        sendBy: UserModel(
            id: 'a'
        ),

        message: 'You simply need to push the button and move to the top of the screen. Then you are able to see all payments and are also able to accept them if you need some more help. It’s really not complicated. Try to get to this point and you can fix your issue with no problem.'
        ,createdAt: DateTime(2020,9,2,16,55)),
    ChatMessage(
        message: "Somehow I can't transfer to your account. Do you know why it that. Is there  some way of restriction?",
        sendBy: UserModel(
            id: 'a'
        ),
        createdAt:DateTime(2020,9,2,14,44)
    ),
    ChatMessage(
        message: "Hey, I have heared that there could be some problem with the payment. Do you know something about this? If you want to I could help you trigger the payment. This should be absolutly no problem for me.",
        sendBy: UserModel(
            id: 'b'
        ),
        createdAt:DateTime(2020,9,2,16,44)
    ),
    ChatMessage(
        message: 'Yeah a little help would be awesome!',
        sendBy: UserModel(
            id: 'a'
        ),
        createdAt:DateTime(2020,9,2,16,50)
    ),
    ChatMessage(
      message: 'Sure tell me exactly what you are doing.',
      createdAt: DateTime(2020,9,2,16,56),
      sendBy: UserModel(
          id: 'b'
      ),
    ),
    ChatMessage(
        sendBy: UserModel(
            id: 'a'
        ),

        message: 'You simply need to push the button and move to the top of the screen. Then you are able to see all payments and are also able to accept them if you need some more help. It’s really not complicated. Try to get to this point and you can fix your issue with no problem.'
        ,createdAt: DateTime(2020,9,2,16,55)),*/
  ];
  static List<Product>productList=[
    Product(
        id: 'sadfsdf',
        name: 'Wagyu Beef Ribeye Steak',
        imageUrl:
        'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
        quantity: 2,
        createdBy: UserModel(
            name: 'Vanessa Gantikow-Schröder',
            imageUrl:
            'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
        price: 3,
        availableStatus: AvailableStatus.plenty,
        alternativeProduct: [
          Product(
              id: 'sadfsdf',
              name: 'Beef Ribeye Steak, 1.12 - 2.0 lb',
              imageUrl:
              'https://i5.walmartimages.com/asr/4acce8a6-6b50-4db2-b6a5-3d4bad6e0840.2fa574f42d693e990f9bb8b8175b6f7b.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              quantity: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              price: 3,
              availableStatus: AvailableStatus.plenty,
              enableUnit: true,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',

              )),
          Product(
              id: 'sadfasqsdf',
              name: 'Beef Choice Angus Ribeye Steak, 1.5 - 2.6 lb',
              imageUrl:
              'https://i5.walmartimages.com/asr/a5b8a217-9dcc-448e-83ac-aa6e95e554b4.71e27a5adbb367d89c6d0d3e33ea1226.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              quantity: 10,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
        ],
        storeDetails: StoreDataModel(
          name: 'REWE',
          steetNo: '2',
          image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
          street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',
        )),
    Product(
        id: 'sadfasqsdf',
        name: 'Semi Skimmed Milk',
        imageUrl:
        'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
        quantity: 10,
        price: 2,
        enableUnit: true,
        createdBy: UserModel(
            name: 'Vanessa Gantikow-Schröder',
            imageUrl:
            'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
        availableStatus: AvailableStatus.few,
        alternativeProduct: [
          Product(
              id: 'sadfasqsdf',
              name: 'Natrel Skim Shelf Stable Milk, 32 oz, 6 Pack',
              imageUrl:
              'https://i5.walmartimages.com/asr/9ec184b5-872e-4d05-bbe5-747630502f4d.e1bb623d460ccbd3de60754824d48dc5.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              quantity: 10,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'sadfasqsdf',
              name: 'Skim Plus Fat-Free Skim Milk with Vitamins',
              imageUrl:
              'https://i5.walmartimages.com/asr/e7bca796-fc4a-4ce5-ac43-dce6c8b37c7d_1.b5565fb152f9eb90907fdee21d60306c.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              quantity: 10,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
        ],
        storeDetails: StoreDataModel(
          name: 'REWE',
          steetNo: '2',
          image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
          street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',
        )),
    Product(
        id: 'sadfyxaxsdf',
        name: 'Orangic Black Peppercorns',
        quantity: 1,
        price: 2,
        enableUnit: true,
        createdBy: UserModel(
            name: 'Vanessa Gantikow-Schröder',
            imageUrl:
            'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
        imageUrl:
        'https://i5.walmartimages.com/asr/dd80f1d3-6347-4cff-a3f5-89333367f804.c16c18b1bf6febd8fc208e4033d59e15.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
        availableStatus: AvailableStatus.runOut,
        alternativeProduct: [
          Product(
              id: 'sadfyxaxsdf',
              name: 'Organic Black Pepper, 1 Pound',
              quantity: 1,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
              'https://i5.walmartimages.com/asr/e09b9310-388a-4f96-91b6-0c344663ccc5.b9d5fe1f30ddb2c6b2dd5d5422534cf5.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'sadfyxaxsdf',
              name: 'Spicely Organics Peppercorn Black Club Size ',
              quantity: 1,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
              'https://i5.walmartimages.com/asr/e09b9310-388a-4f96-91b6-0c344663ccc5.b9d5fe1f30ddb2c6b2dd5d5422534cf5.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
        ],
        storeDetails: StoreDataModel(
          name: 'REWE',
          steetNo: '2',
          image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
          street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',
        )),
    Product(
        id: 'sadfsvvevedf',
        name: 'Red Bull Energy Drink',
        quantity: 1,
        price: 2,
        createdBy: UserModel(
            name: 'Vanessa Gantikow-Schröder',
            imageUrl:
            'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
        imageUrl:
        'https://i5.walmartimages.com/asr/7c19969c-d5be-4351-9061-54e00a6320c8_1.cf68e0ecc361dba9d1d5cf9730ede7fa.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
        availableStatus: AvailableStatus.unknown,
        alternativeProduct: [
          Product(
              id: 'sadfsvvevedf',
              name: 'Red Bull Energy Drink, Sugar Free Pear, 12 fl oz',
              quantity: 1,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
              'https://i5.walmartimages.com/asr/d2af5f27-804a-4eb3-8e6a-e12546274fd4_1.faf00112b46d86d31ce767df77977e75.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.unknown,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'sadfsvvevedf',
              name: 'Red Bull Energy Drink Peach Edition,',
              quantity: 1,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
              'https://i5.walmartimages.com/asr/d6d47876-2b6d-482f-aa5f-69fe2ed78a5e_1.c48bd807da20806c65a17d5e86d34182.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
              availableStatus: AvailableStatus.unknown,
              storeDetails: StoreDataModel(
                name: 'REWE',
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
        ],
        storeDetails: StoreDataModel(
          name: 'REWE',
          steetNo: '2',
          image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
          street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',
        )),

  ];
  static List<OrderOrPurchases> completedOrderList = [
    OrderOrPurchases(
      productName: 'White chocolate light',
      shopName: 'REWE',
      type: OrderAndPurchaseType.Order,
      orderAmount: 230,
      status: OrderPurchaseStatus.Finished,
      quantity: 11,
      clientDetails: ClientDetails(
        name: 'Jakob Merz',
        imageUrl: 'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
        street: 'Domstrasse 20 ',
        zip: '50668',
        city: 'Nürnberg',
      ),
      purchaseDetails: PurchaseDetails(

          paymentOption:
          PaymentOption(paymentOptionEnum: PaymentOptionEnum.prepayment, title: AppStrings.PREPAYMENT.tr()),
          listName: 'Household',
          notificationType: NotificationType.shareNotification.notificationValue,
          storeDetails: StoreDataModel(
              steetNo: '2',
              image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
              name: 'REWE',
              street: 'Domstrasse 20 ',
              txtZip: '50668',
              city: 'Nürnberg',
              openingTime: '9:',
              closingTime: '22:'),
          amount: 4,
          customer: UserModel(
              name: 'Jakob Merz',
              imageUrl:
              'https://ath2.unileverservices.com/wp-content/uploads/sites/8/2019/09/hairstyles-for-men-with-round-faces-side-part.jpg'),
          quantity: 9,
          time: DateTime.now(),
          products: [
            Product(
                category: 'GROCERY',
                id: '01',
                name: 'Wagyu Beef Ribeye Steak',
                imageUrl:
                'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 2,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
              category: 'GROCERY',
              id: '02',
              imageUrl:
              'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                name: 'REWE',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              ),
              name: 'Semi Skimmed Milk',
              price: 2,
              quantity: 5,
              availableStatus: AvailableStatus.plenty,
            ),
            Product(
                category: 'GROCERY',
                id: '03',
                imageUrl:
                'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                name: 'Organic Black Peppercorns',
                quantity: 1,
                price: 2,
                availableStatus: AvailableStatus.runOut),
            Product(
                category: 'GROCERY',
                id: '04',
                imageUrl:
                'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                price: 10,
                name: 'Red Bull Energy Drink',
                quantity: 1,
                availableStatus: AvailableStatus.unknown),
            Product(
                category: 'GROCERY',
                id: '01',
                name: 'Wagyu Beef Ribeye Steak',
                imageUrl:
                'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 2,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
              category: 'GROCERY',
              id: '02',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                name: 'REWE',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              ),
              name: 'Semi Skimmed Milk',
              imageUrl:
              'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              price: 2,
              quantity: 5,
              availableStatus: AvailableStatus.plenty,
            ),
            Product(
                category: 'GROCERY',
                id: '03',
                imageUrl:
                'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                name: 'Organic Black Peppercorns',
                quantity: 1,
                price: 2,
                availableStatus: AvailableStatus.runOut),
            Product(
                category: 'GROCERY',
                id: '04',
                imageUrl:
                'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                price: 10,
                name: 'Red Bull Energy Drink',
                quantity: 1,
                availableStatus: AvailableStatus.unknown),
            Product(
                category: 'GROCERY',
                id: '01',
                name: 'Wagyu Beef Ribeye Steak',
                imageUrl:
                'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 2,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
              category: 'GROCERY',
              id: '02',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                name: 'REWE',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              ),
              name: 'Semi Skimmed Milk',
              imageUrl:
              'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              price: 2,
              quantity: 5,
              availableStatus: AvailableStatus.plenty,
            ),
            Product(
                category: 'GROCERY',
                id: '03',
                imageUrl:
                'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                name: 'Organic Black Peppercorns',
                quantity: 1,
                price: 2,
                availableStatus: AvailableStatus.runOut),
            Product(
                category: 'GROCERY',
                id: '04',
                imageUrl:
                'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  image: 'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  name: 'REWE',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                price: 10,
                name: 'Red Bull Energy Drink',
                quantity: 1,
                availableStatus: AvailableStatus.unknown),
          ]),
      candidates: [ CourierCandidate(
        name: 'Vanessa Gantikow-Schröder',
        stars: 3,
        verifyStatus: VerifyStatus.Reliable,
        reliable: true,
        approved: true,
        insured: true,
        favourite: true,
        charge: 10,
        reviews: 12,
        time: '1 hours ago',
        imageUrl:
        'https://images.unsplash.com/photo-1563122870-6b0b48a0af09?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmxhY2slMjBtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
        status: 'Updated',
      ),CourierCandidate(
        reviews: 10,
        charge: 12,
        name: 'Vanessa Gantikow-Schröder',
        stars: 3,
        verifyStatus: VerifyStatus.Reliable,
        time: '1 hours ago',
        imageUrl:
        'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
        status: 'Updated',
      )],
      proposalDetails: ProposalDetails(
          totalProposals: 10, unseenProposal: 7, time: DateTime.now().subtract(new Duration(minutes: 10))),
    ),
    OrderOrPurchases(
      type: OrderAndPurchaseType.Order,
      productName: 'White chocolate light',
      shopName: 'Lidl',
      orderAmount: 130,
      clientDetails: ClientDetails(
        name: 'Jakob Merz',
        imageUrl: 'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
        street: 'Domstrasse 20 ',
        zip: '50668',
        city: 'Nürnberg',
      ),
      status: OrderPurchaseStatus.Finished,
      quantity: 5,
      purchaseDetails: PurchaseDetails(
          paymentOption:
          PaymentOption(title: AppStrings.NO_PREFERENCES.tr(), paymentOptionEnum: PaymentOptionEnum.prepayment),
          listName: 'Household',
          notificationType: NotificationType.shareNotification.notificationValue,
          storeDetails: StoreDataModel(
              steetNo: '2',
              image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
              name: 'Lidl',
              street: 'Hauptstrasse 6a',
              city: 'Düsseldorf',
              txtZip: '56456',
              openingTime: '9:',
              closingTime: '22:'),
          amount: 4,
          customer: UserModel(
              name: 'Jakob Merz',
              imageUrl:
              'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/sample_profile.png?alt=media&token=5bbcd983-45aa-4c98-8487-1b8a79650ac7'),
          quantity: 9,
          time: DateTime.now(),
          products: [
            Product(
                category: 'GROCERY',
                id: '01',
                imageUrl:
                'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                name: 'Wagyu Beef Ribeye Steak',
                quantity: 2,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'Lidl',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                )),
            Product(
              category: 'GROCERY',
              imageUrl:
              'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              id: '02',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              name: 'Semi Skimmed Milk',
              price: 2,
              quantity: 5,
              availableStatus: AvailableStatus.plenty,
            ),
            Product(
                category: 'GROCERY',
                imageUrl:
                'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                id: '03',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  name: 'Lidl',
                  steetNo: '2',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                ),
                name: 'Organic Black Peppercorns',
                quantity: 1,
                price: 2,
                availableStatus: AvailableStatus.runOut),
            Product(
                category: 'GROCERY',
                id: '04',
                imageUrl:
                'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'Lidl',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                ),
                price: 10,
                name: 'Red Bull Energy Drink',
                quantity: 1,
                availableStatus: AvailableStatus.unknown),
            Product(
                category: 'GROCERY',
                id: '01',
                imageUrl:
                'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                name: 'Wagyu Beef Ribeye Steak',
                quantity: 2,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  name: 'Lidl',
                  steetNo: '2',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                )),
            Product(
              category: 'GROCERY',
              imageUrl:
              'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              id: '02',
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              storeDetails: StoreDataModel(
                steetNo: '2',
                name: 'Lidl',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
              ),
              name: 'Semi Skimmed Milk',
              price: 2,
              quantity: 5,
              availableStatus: AvailableStatus.plenty,
            ),
            Product(
                category: 'GROCERY',
                imageUrl:
                'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                id: '03',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'Lidl',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                ),
                name: 'Organic Black Peppercorns',
                quantity: 1,
                price: 2,
                availableStatus: AvailableStatus.runOut),
            Product(
                category: 'GROCERY',
                id: '04',
                imageUrl:
                'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'Lidl',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                ),
                price: 10,
                name: 'Red Bull Energy Drink',
                quantity: 1,
                availableStatus: AvailableStatus.unknown),
          ]),
      proposalDetails: ProposalDetails(
          totalProposals: 9, unseenProposal: 5, time: DateTime.now().subtract(new Duration(minutes: 15))),
      candidates: [
        CourierCandidate(
          name: 'Vanessa Gantikow-Schröder',
          stars: 3,
          verifyStatus: VerifyStatus.Reliable,
          reliable: true,
          approved: true,
          insured: true,
          favourite: true,
          charge: 10,
          reviews: 12,
          time: '1 hours ago',
          imageUrl:
          'https://images.unsplash.com/photo-1563122870-6b0b48a0af09?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmxhY2slMjBtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
          status: 'Updated',
        ),CourierCandidate(
          reviews: 10,
          charge: 12,
          name: 'Vanessa Gantikow-Schröder',
          stars: 3,
          verifyStatus: VerifyStatus.Reliable,
          time: '1 hours ago',
          imageUrl:
          'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
          status: 'Updated',
        )],
    ),
    OrderOrPurchases(
        type: OrderAndPurchaseType.Order,
        productName: 'White chocolate light',
        shopName: 'Lidl',
        orderAmount: 130,
        status: OrderPurchaseStatus.Finished,
        quantity: 5,
        clientDetails: ClientDetails(
            name: 'Jakob Merz',
            imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/sample_profile.png?alt=media&token=5bbcd983-45aa-4c98-8487-1b8a79650ac7'
        ),


        proposalDetails: ProposalDetails(
            totalProposals: 9, unseenProposal: 5, time: DateTime.now().subtract(new Duration(minutes: 15))),
        candidates: [ CourierCandidate(
          name: 'Vanessa Gantikow-Schröder',
          stars: 3,
          verifyStatus: VerifyStatus.Reliable,
          reliable: true,
          approved: true,
          insured: true,
          favourite: true,
          charge: 10,
          reviews: 12,
          time: '1 hours ago',
          imageUrl:
          'https://images.unsplash.com/photo-1563122870-6b0b48a0af09?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmxhY2slMjBtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
          status: 'Updated',
        ),CourierCandidate(
          reviews: 10,
          charge: 12,
          name: 'Vanessa Gantikow-Schröder',
          stars: 3,
          verifyStatus: VerifyStatus.Reliable,
          time: '1 hours ago',
          imageUrl:
          'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
          status: 'Updated',
        )],
        purchaseDetails: PurchaseDetails(
            listName: 'Household',
            notificationType: NotificationType.shareNotification.notificationValue,
            paymentOption: PaymentOption(
                title: AppStrings.PAYMENT_ON_DELIVERY.tr(), paymentOptionEnum: PaymentOptionEnum.prepayment),
            storeDetails: StoreDataModel(
                steetNo: '2',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                name: 'Lidl',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
                openingTime: '9:',
                closingTime: '22:'),
            amount: 4,
            customer: UserModel(
                name: 'Jakob Merz',
                imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/sample_profile.png?alt=media&token=5bbcd983-45aa-4c98-8487-1b8a79650ac7'),
            quantity: 9,
            time: DateTime.now(),

            products: [
              Product(
                  category: 'GROCERY',
                  imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                  id: '01',
                  name: 'Wagyu Beef Ribeye Steak',
                  quantity: 2,
                  price: 2,
                  createdBy: UserModel(
                      name: 'Vanessa Gantikow-Schröder',
                      imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                  availableStatus: AvailableStatus.few,
                  storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'Lidl',
                    image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                    street: 'Hauptstrasse 6a',
                    city: 'Düsseldorf',
                    txtZip: '56456',
                  )),
              Product(
                category: 'GROCERY',
                id: '02',
                imageUrl:
                'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  name: 'Lidl',
                  steetNo: '2',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                ),
                name: 'Semi Skimmed Milk',
                price: 2,
                quantity: 5,
                availableStatus: AvailableStatus.plenty,
              ),

              Product(
                  category: 'GROCERY',
                  id: '03',
                  imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                  createdBy: UserModel(
                      name: 'Vanessa Gantikow-Schröder',
                      imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                  storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'Lidl',
                    image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                    street: 'Hauptstrasse 6a',
                    city: 'Düsseldorf',
                    txtZip: '56456',
                  ),
                  name: 'Organic Black Peppercorns',
                  quantity: 1,
                  price: 2,
                  availableStatus: AvailableStatus.runOut),
              Product(
                  category: 'GROCERY',
                  id: '04',
                  imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                  createdBy: UserModel(
                      name: 'Vanessa Gantikow-Schröder',
                      imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                  storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'Lidl',
                    image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                    street: 'Hauptstrasse 6a',
                    city: 'Düsseldorf',
                    txtZip: '56456',
                  ),
                  price: 10,
                  name: 'Red Bull Energy Drink',
                  quantity: 1,
                  availableStatus: AvailableStatus.unknown),
            ])),
    OrderOrPurchases(
        type: OrderAndPurchaseType.Order,
        productName: 'White chocolate light',
        shopName: 'Lidl',
        orderAmount: 130,
        clientDetails: ClientDetails(
          name: 'Jakob Merz',
          imageUrl: 'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
          street: 'Domstrasse 20 ',
          zip: '50668',
          city: 'Nürnberg',
        ),
        status: OrderPurchaseStatus.Finished,
        quantity: 5,
        proposalDetails: ProposalDetails(
            totalProposals: 9, unseenProposal: 5, time: DateTime.now().subtract(new Duration(minutes: 15))),
        candidates:[ CourierCandidate(
          name: 'ack Fisher',
          stars: 4,
          verifyStatus: VerifyStatus.Reliable,
          time: '1 hours ago',
          imageUrl:
          'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
          status: 'Updated',
        ),
          CourierCandidate(
            name: 'Vanessa Gantikow-Schröder',
            stars: 3,
            verifyStatus: VerifyStatus.Reliable,
            reliable: true,
            approved: true,
            insured: true,
            charge: 10,
            reviews: 12,
            time: '1 hours ago',
            imageUrl:
            'https://images.unsplash.com/photo-1563122870-6b0b48a0af09?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmxhY2slMjBtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
            status: 'Updated',
          ),CourierCandidate(
            reviews: 10,
            charge: 12,
            name: 'Vanessa Gantikow-Schröder',
            stars: 3,
            verifyStatus: VerifyStatus.Reliable,
            time: '1 hours ago',
            imageUrl:
            'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
            status: 'Updated',
          )],
        purchaseDetails: PurchaseDetails(

            paymentOption: PaymentOption(
                title: AppStrings.PAYMENT_ON_DELIVERY.tr(), paymentOptionEnum: PaymentOptionEnum.prepayment),
            listName: 'Household',
            notificationType: NotificationType.shareNotification.notificationValue,
            storeDetails: StoreDataModel(
                steetNo: '2',
                image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                name: 'Lidl',
                street: 'Hauptstrasse 6a',
                city: 'Düsseldorf',
                txtZip: '56456',
                openingTime: '9:',
                closingTime: '22:'),
            amount: 4,
            customer: UserModel(
                name: 'Jakob Merz',
                imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/sample_profile.png?alt=media&token=5bbcd983-45aa-4c98-8487-1b8a79650ac7'),
            quantity: 9,
            time: DateTime.now(),
            products: [
              Product(
                  category: 'GROCERY',
                  imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                  id: '01',
                  name: 'Wagyu Beef Ribeye Steak',
                  quantity: 2,
                  price: 2,
                  createdBy: UserModel(
                      name: 'Vanessa Gantikow-Schröder',
                      imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                  availableStatus: AvailableStatus.few,
                  storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'Lidl',
                    image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                    street: 'Hauptstrasse 6a',
                    city: 'Düsseldorf',
                    txtZip: '56456',
                  )),
              Product(
                category: 'GROCERY',
                id: '02',
                imageUrl:
                'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                storeDetails: StoreDataModel(
                  steetNo: '2',
                  name: 'Lidl',
                  image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  street: 'Hauptstrasse 6a',
                  city: 'Düsseldorf',
                  txtZip: '56456',
                ),
                name: 'Semi Skimmed Milk',
                price: 2,
                quantity: 5,
                availableStatus: AvailableStatus.plenty,
              ),
              Product(
                  category: 'GROCERY',
                  id: '03',
                  imageUrl:
                  'https://i5.walmartimages.com/asr/4bb31ba4-a4bb-4128-b91f-a73ce6b3ae0f.e6c886b8fa63485a5f768128643af220.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                  createdBy: UserModel(
                      name: 'Vanessa Gantikow-Schröder',
                      imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                  storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'Lidl',
                    image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                    street: 'Hauptstrasse 6a',
                    city: 'Düsseldorf',
                    txtZip: '56456',
                  ),
                  name: 'Organic Black Peppercorns',
                  quantity: 1,
                  price: 2,
                  availableStatus: AvailableStatus.runOut),
              Product(
                  category: 'GROCERY',
                  id: '04',
                  imageUrl:
                  'https://i5.walmartimages.com/asr/5cceddef-e369-4187-a317-0d1a8dedc565_1.138b9a1b8c7db968e875b618df098d10.png?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                  createdBy: UserModel(
                      name: 'Vanessa Gantikow-Schröder',
                      imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                  storeDetails: StoreDataModel(
                    steetNo: '2',
                    name: 'Lidl',
                    image: 'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                    street: 'Hauptstrasse 6a',
                    city: 'Düsseldorf',
                    txtZip: '56456',
                  ),
                  price: 10,
                  name: 'Red Bull Energy Drink',
                  quantity: 1,
                  availableStatus: AvailableStatus.unknown),
            ])),
  ];
}
