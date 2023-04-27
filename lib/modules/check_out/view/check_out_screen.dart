import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/modules/check_out/view/maps_view.dart';
import 'package:foodit/utils/widgets/app_button.dart';
import 'package:foodit/utils/widgets/my_textfield.dart';
import 'package:foodit/utils/widgets/scrollable_column.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../utils/widgets/my_dropdown.dart';
import '../../cart/provider/order_provider.dart';
import '../../cart/provider/map_controller.dart';
import '../provider/check_out_provider.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  TextEditingController? addressController;
  TextEditingController? nameController;
  TextEditingController? phoneController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OrderProvider>().initS();
    });
    nameController = TextEditingController(
      text: context.read<OrderProvider>().user?.name,
    );
    phoneController =
        TextEditingController(text: context.read<OrderProvider>().user?.phone);
    addressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    addressController?.dispose();
    nameController?.dispose();
    phoneController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OrderProvider provider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check out"),
      ),
      body: ScrollableColumn(children: [
        Text(
          "Order Type",
          style: context.textStyles.displayLarge,
        ).pb(8),
        MyDropDown<OrderType>(
            validator: (value) {
              if (value == null) {
                return "Please select order type";
              }
              return null;
            },
            items: [OrderType.Delivery, OrderType.TakeOut]
                .map((e) =>
                    DropdownMenuItem<OrderType>(value: e, child: Text(e.name)))
                .toList(),
            hintText: "Select OrderType",
            value: context.read<OrderProvider>().selectedOrderType,
            onChanged: (value) {
              context.read<OrderProvider>().onSelectOrderType(value);
            }).pb(16),
        Consumer<OrderProvider>(
          builder: (context, provider, child) {
            return provider.orderTypeInt == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pick Location",
                        style: context.textStyles.displayLarge,
                      ).pb(8),
                      const MapsView(),
                      MyTextField(
                        textController: addressController,
                        label: "Address",
                        hintText: "Landmark, Famous Place, Chowk Namew",
                      ).pt(16),
                    ],
                  )
                : const SizedBox();
          },
        ).pb(16),
        MyTextField(
          textController: nameController,
          label: "Name",
        ).pb(16),
        MyTextField(
          readOnly: true,
          textController: phoneController,
          label: "Phone Number",
        ).pb(24),
        AppButton(
            onPressed: () {
              final MapController1 controller = Get.find<MapController1>();
              Map data = {
                "type": provider.orderTypeInt,
                "phone": phoneController?.text,
                "lat": controller.locationModel.value.latitude,
                "lng": controller.locationModel.value.longitude,
                "user_id": provider.user?.id,
                "name": nameController?.text,
                "address": addressController?.text,
                "items": provider.orderItems,
              };
              print(data);
              provider.postOrder(context, data);
            },
            label: "Place Order"),
      ]),
    );
  }
}
