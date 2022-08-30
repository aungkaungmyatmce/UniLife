import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUtils {
  static Widget postList = ListView.separated(
    separatorBuilder: (context, index) => Divider(),
    itemBuilder: (context, index) => Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        //enabled: _enabled,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    height: 47.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
            ),

            ///Profile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: Container(
                      //width: double.infinity,
                      height: 8.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: 200,
                      height: 30.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    itemCount: 5,
  );

  static Widget bookMark = Column(
    children: [
      const SizedBox(height: 50),
      Expanded(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) => Container(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              //enabled: _enabled,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          height: 47.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                  ),

                  ///Profile
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Container(
                            //width: double.infinity,
                            height: 8.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: 200,
                            height: 30.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          itemCount: 5,
        ),
      )
    ],
  );

  static Widget postDetail = Column(
    children: [
      const SizedBox(height: 50),
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        //enabled: _enabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: 200,
              height: 25.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: Container(
                      //width: double.infinity,
                      height: 8.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: 300,
                      height: 30.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              //margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 200.0,
              color: Colors.white,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: 200,
              height: 47.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
            ),
          ],
        ),
      )
    ],
  );

  static Widget profile = Padding(
      padding: EdgeInsets.only(top: 15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        //enabled: _enabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Container(
                      //width: double.infinity,
                      height: 8.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: 80,
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: 80,
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: 200,
              height: 47.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Container(
              //margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 200.0,
              color: Colors.white,
            ),
            // Container(
            //     child: Shimmer.fromColors(
            //   baseColor: Colors.grey.shade100,
            //   highlightColor: Colors.grey.shade50,
            //   child: Column(
            //     children: [
            //       Container(
            //         child: Shimmer.fromColors(
            //           baseColor: Colors.grey.shade300,
            //           highlightColor: Colors.grey.shade100,
            //           //enabled: _enabled,
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Row(
            //                 children: [
            //                   Expanded(
            //                     child: Container(
            //                       margin: const EdgeInsets.symmetric(
            //                           horizontal: 10, vertical: 10),
            //                       height: 47.0,
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(15),
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   ),
            //                   Container(
            //                     margin: const EdgeInsets.symmetric(
            //                         horizontal: 10, vertical: 10),
            //                     width: 100,
            //                     height: 100,
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(15),
            //                       color: Colors.white,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Container(
            //                 margin: const EdgeInsets.symmetric(
            //                     horizontal: 10, vertical: 10),
            //                 height: 150.0,
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(15),
            //                   color: Colors.white,
            //                 ),
            //               ),
            //
            //               ///Profile
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 15),
            //                 child: Row(
            //                   mainAxisSize: MainAxisSize.max,
            //                   children: [
            //                     CircleAvatar(
            //                       radius: 25,
            //                       child: Container(
            //                         //width: double.infinity,
            //                         height: 8.0,
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(10),
            //                           color: Colors.white,
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       child: Container(
            //                         margin: EdgeInsets.symmetric(horizontal: 20),
            //                         width: 200,
            //                         height: 30.0,
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(15),
            //                           color: Colors.white,
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       Container(
            //         child: Shimmer.fromColors(
            //           baseColor: Colors.grey.shade300,
            //           highlightColor: Colors.grey.shade100,
            //           //enabled: _enabled,
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Row(
            //                 children: [
            //                   Expanded(
            //                     child: Container(
            //                       margin: const EdgeInsets.symmetric(
            //                           horizontal: 10, vertical: 10),
            //                       height: 47.0,
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(15),
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   ),
            //                   Container(
            //                     margin: const EdgeInsets.symmetric(
            //                         horizontal: 10, vertical: 10),
            //                     width: 100,
            //                     height: 100,
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(15),
            //                       color: Colors.white,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Container(
            //                 margin: const EdgeInsets.symmetric(
            //                     horizontal: 10, vertical: 10),
            //                 height: 150.0,
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(15),
            //                   color: Colors.white,
            //                 ),
            //               ),
            //
            //               ///Profile
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 15),
            //                 child: Row(
            //                   mainAxisSize: MainAxisSize.max,
            //                   children: [
            //                     CircleAvatar(
            //                       radius: 25,
            //                       child: Container(
            //                         //width: double.infinity,
            //                         height: 8.0,
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(10),
            //                           color: Colors.white,
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       child: Container(
            //                         margin: EdgeInsets.symmetric(horizontal: 20),
            //                         width: 200,
            //                         height: 30.0,
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(15),
            //                           color: Colors.white,
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )),
          ],
        ),
      ));
}
