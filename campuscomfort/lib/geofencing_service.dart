import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show pi, cos, sin, sqrt, asin, pow;

class UMDBuilding {
  final String officialName;
  final List<String> validMatches;
  final List<LatLng> vertices;

  // Returns true if str is a substring of any String in validMatches (non case sensitive)
  bool nameMatches(String str) {
    final searchTerm = str.toLowerCase();
    
    for (final buildingName in validMatches) {
      final lowercaseName = buildingName.toLowerCase();
      if (lowercaseName.contains(searchTerm)) {
        return true;
      }
    }
    
    return false;
  }
  
  UMDBuilding({required this.officialName, required this.validMatches, required this.vertices});
}

class GeofencingService {
  final List<UMDBuilding> buildings = [
    UMDBuilding(
      officialName: "Brendan Iribe Center for Computer Science and Engineering",
      validMatches: ["Brendan Iribe Center for Computer Science and Engineering",
        "Iribe",
        "Iribe Center",
        "Brendan Iribe Center",
      ],
      vertices: [
        const LatLng(38.989333, -76.936871),
        const LatLng(38.989004, -76.936559),
        const LatLng(38.988962, -76.935561),
        const LatLng(38.989121, -76.935551),
        const LatLng(38.989171, -76.935905),
        const LatLng(38.989538, -76.935782),
        const LatLng(38.989588, -76.936077),
        const LatLng(38.989371, -76.936115),
        const LatLng(38.989250, -76.936335),
        const LatLng(38.989484, -76.936700),
      ],
    ),
    UMDBuilding(
      officialName: "Computer Science Instructional Center",
      validMatches: ["Computer Science Instructional Center",
        "CSI",
        "CS Building",
        "Computer Science Building",
        "Old CS Building",
      ],
      vertices: [
        const LatLng(38.990126, -76.936356),
        const LatLng(38.989838, -76.936351),
        const LatLng(38.989892, -76.935932),
        const LatLng(38.990101, -76.935943),
      ],
    ),
    UMDBuilding(
      officialName: "Wind Tunnel Building",
      validMatches: ["Wind Tunnel Building",
        "Wind Tunnel",
      ],
      vertices: [
        const LatLng(38.989684, -76.936560),
        const LatLng(38.990163, -76.936780),
        const LatLng(38.990038, -76.937161),
        const LatLng(38.989617, -76.936979),
        const LatLng(38.989692, -76.936705),
        const LatLng(38.989655, -76.936684),
      ],
    ),
    UMDBuilding(
      officialName: "A.V. Williams",
      validMatches: ["A.V. Williams",
        "Office Hours",
      ],
      vertices: [
        const LatLng(38.990276, -76.936168),
        const LatLng(38.991331, -76.936190),
        const LatLng(38.991327, -76.937113),
        const LatLng(38.991097, -76.937102),
        const LatLng(38.991106, -76.936506),
        const LatLng(38.990480, -76.936501),
        const LatLng(38.990468, -76.937091),
      ],
    ),
    UMDBuilding(
      officialName: "Engineering Annex",
      validMatches: ["Engineering Annex"],
      vertices: [
        const LatLng(38.990576, -76.936705),
        const LatLng(38.990689, -76.936710),
        const LatLng(38.990676, -76.937043),
        const LatLng(38.990789, -76.937043),
        const LatLng(38.990789, -76.936700),
        const LatLng(38.990847, -76.936716),
        const LatLng(38.990860, -76.937161),
        const LatLng(38.990576, -76.937161),
      ],
    ),
    UMDBuilding(
      officialName: "Energy Research Facility",
      validMatches: ["Energy Research Facility"],
      vertices: [
        const LatLng(38.991585, -76.936565),
        const LatLng(38.991702, -76.936554),
        const LatLng(38.991698, -76.936420),
        const LatLng(38.991844, -76.936426),
        const LatLng(38.991852, -76.936571),
        const LatLng(38.992269, -76.936576),
        const LatLng(38.992273, -76.936673),
        const LatLng(38.992486, -76.936673),
        const LatLng(38.992486, -76.936844),
        const LatLng(38.992273, -76.936839),
        const LatLng(38.992256, -76.937145),
        const LatLng(38.991573, -76.937140),
      ],
    ),
    UMDBuilding(
      officialName: "Biomolecular Sciences Building",
      validMatches: ["Biomolecular Sciences Building"],
      vertices: [
        const LatLng(38.992736, -76.937408),
        const LatLng(38.992982, -76.937408),
        const LatLng(38.992978, -76.937714),
        const LatLng(38.993032, -76.937704),
        const LatLng(38.993023, -76.937982),
        const LatLng(38.992686, -76.937976),
        const LatLng(38.992677, -76.937638),
        const LatLng(38.992719, -76.937628),
      ],
    ),
    UMDBuilding(
      officialName: "A. James Clark Hall",
      validMatches: ["A. James Clark Hall",
        "Clark Hall",
        "James Clark Hall",
      ],
      vertices: [
        const LatLng(38.992452, -76.937499),
        const LatLng(38.991522, -76.937574),
        const LatLng(38.991485, -76.938036),
        const LatLng(38.992440, -76.937917),
      ],
    ),
    UMDBuilding(
      officialName: "Jeong H. Kim Engineering Building",
      validMatches: ["Jeong H. Kim Engineering Building",
        "Engineering Buidling",
        "Kim Engineering Building",
      ],
      vertices: [
        const LatLng(38.990880, -76.937542),
        const LatLng(38.991260, -76.937504),
        const LatLng(38.991264, -76.938605),
        const LatLng(38.990697, -76.938502),
        const LatLng(38.990693, -76.938347),
        const LatLng(38.990555, -76.938341),
        const LatLng(38.990543, -76.938014),
        const LatLng(38.990805, -76.938008),
        const LatLng(38.990793, -76.937880),
        const LatLng(38.990868, -76.937794),
      ],
    ),
    UMDBuilding(
      officialName: "E.A. Fernandez IDEA Factory",
      validMatches: ["E.A. Fernandez IDEA Factory",
        "IDEA Factory",
        "IDEA",
      ],
      vertices: [
        const LatLng(38.990868, -76.937794),
        const LatLng(38.990447, -76.937810),
        const LatLng(38.990468, -76.938588),
        const LatLng(38.990288, -76.938577),
      ],
    ),
    UMDBuilding(
      officialName: "Engineering Laboratory Building",
      validMatches: ["Engineering Laboratory Building",
        "Engineering Lab",
      ],
      vertices: [
        const LatLng(38.989150, -76.937370),
        const LatLng(38.989492, -76.937370),
        const LatLng(38.989475, -76.938551),
        const LatLng(38.989146, -76.938561),
        const LatLng(38.989138, -76.938368),
        const LatLng(38.989058, -76.938379),
        const LatLng(38.989079, -76.937987),
        const LatLng(38.989133, -76.937987),
      ],
    ),
    UMDBuilding(
      officialName: "Glen L. Martin Hall",
      validMatches: ["Glen L. Martin Hall",
        "Martin Hall",
      ],
      vertices: [
        const LatLng(38.988812, -76.937021),
        const LatLng(38.988950, -76.937037),
        const LatLng(38.989021, -76.937493),
        const LatLng(38.988958, -76.937982),
        const LatLng(38.989083, -76.937976),
        const LatLng(38.989071, -76.938374),
        const LatLng(38.988937, -76.938481),
        const LatLng(38.988929, -76.938888),
        const LatLng(38.988783, -76.938867),
      ],
    ),
    UMDBuilding(
      officialName: "William E. Kirwan Hall",
      validMatches: ["William E. Kirwan Hall",
        "Kirwan Hall",
        "Kirwan",
        "Math Building",
        "STEM Library",
      ],
      vertices: [
        const LatLng(38.988662, -76.938883),
        const LatLng(38.988900, -76.938883),
        const LatLng(38.988900, -76.938985),
        const LatLng(38.989050, -76.938996),
        const LatLng(38.989050, -76.939479),
        const LatLng(38.988841, -76.939463),
        const LatLng(38.988858, -76.939194),
        const LatLng(38.988462, -76.939205),
        const LatLng(38.988320, -76.939404),
        const LatLng(38.988316, -76.939634),
        const LatLng(38.988170, -76.939624),
        const LatLng(38.988179, -76.939189),
        const LatLng(38.988358, -76.938996),
        const LatLng(38.988658, -76.939017),
      ],
    ),
    UMDBuilding(
      officialName: "John S. Toll Physics Building",
      validMatches: ["John S. Toll Physics Building",
        "Toll Physics",
        "Physics Building",
        "Toll Physics Building",
        "John Toll Physics Building",
        "Physics Hall"
      ],
      vertices: [
        const LatLng(38.988174, -76.939838),
        const LatLng(38.988329, -76.939865),
        const LatLng(38.988333, -76.940058),
        const LatLng(38.988433, -76.940048),
        const LatLng(38.988416, -76.939801),
        const LatLng(38.988666, -76.939661),
        const LatLng(38.989017, -76.939726),
        const LatLng(38.989037, -76.940032),
        const LatLng(38.989213, -76.940042),
        const LatLng(38.989192, -76.940418),
        const LatLng(38.989033, -76.940418),
        const LatLng(38.988987, -76.940295),
        const LatLng(38.988917, -76.940300),
        const LatLng(38.988925, -76.940477),
        const LatLng(38.988704, -76.940466),
        const LatLng(38.988696, -76.940273),
        const LatLng(38.988333, -76.940268),
        const LatLng(38.988329, -76.940461),
        const LatLng(38.988174, -76.940461),
      ],
    ),
    UMDBuilding(
      officialName: "Chemistry Building",
      validMatches: ["Chemistry Building",
        "Chem Building",
      ],
      vertices: [
        const LatLng(38.989192, -76.938893),
        const LatLng(38.989254, -76.938748),
        const LatLng(38.989425, -76.938845),
        const LatLng(38.990034, -76.938850),
        const LatLng(38.990005, -76.939081),
        const LatLng(38.989404, -76.939081),
        const LatLng(38.989400, -76.939349),
        const LatLng(38.990001, -76.939339),
        const LatLng(38.990001, -76.939918),
        const LatLng(38.990046, -76.939918),
        const LatLng(38.990030, -76.940487),
        const LatLng(38.989813, -76.940471),
        const LatLng(38.989809, -76.940197),
        const LatLng(38.989675, -76.940203),
        const LatLng(38.989663, -76.940434),
        const LatLng(38.989425, -76.940423),
        const LatLng(38.989379, -76.940208),
        const LatLng(38.989242, -76.940203),
        const LatLng(38.989221, -76.940047),
      ],
    ),
    UMDBuilding(
      officialName: "J.M. Patterson Building",
      validMatches: ["J.M. Patterson Building",
        "Patterson Building",
        "J.M. Patterson",
        "J.M. Patterson Hall",
        "JM Patterson",
        "JM Patterson Hall",
        "JM Patterson Building",
      ],
      vertices: [
        const LatLng(38.990272, -76.939935),
        const LatLng(38.990472, -76.939940),
        const LatLng(38.990476, -76.940111),
        const LatLng(38.990559, -76.940101),
        const LatLng(38.990568, -76.939940),
        const LatLng(38.990768, -76.939945),
        const LatLng(38.990764, -76.940535),
        const LatLng(38.990259, -76.940530),
      ],
    ),
    UMDBuilding(
      officialName: "Chemical and Nuclear Engineering Building",
      validMatches: ["Chemical and Nuclear Engineering Building",
        "Chem and Nuclear Engineering Building",
        "Nuclear Engineering",
        "Nuclear Engineering Building",
        "Chemical Engineering",
        "Chemical Engineering Building",
      ],
      vertices: [
        const LatLng(38.990284, -76.938807),
        const LatLng(38.990935, -76.938802),
        const LatLng(38.990922, -76.939178),
        const LatLng(38.990751, -76.939178),
        const LatLng(38.990764, -76.938942),
        const LatLng(38.990564, -76.938931),
        const LatLng(38.990564, -76.939323),
        const LatLng(38.990876, -76.939317),
        const LatLng(38.990880, -76.939575),
        const LatLng(38.990772, -76.939591),
        const LatLng(38.990772, -76.939747),
        const LatLng(38.990534, -76.939741),
        const LatLng(38.990534, -76.939559),
        const LatLng(38.990267, -76.939532),
        const LatLng(38.990272, -76.939301),
        const LatLng(38.990347, -76.939296),
        const LatLng(38.990338, -76.939060),
        const LatLng(38.990280, -76.939038),
      ],
    ),
    UMDBuilding(
      officialName: "Animal Sciences/Agricultural Engineering Building",
      validMatches: ["Animal Sciences/Agricultural Engineering Building",
        "Animal Sciences",
        "Animal Sciences Building",
        "Agricultural Engineering",
        "Agricultural Engineering Building",
        "Ag Engineering",
        "Ag Engineering Building",
      ],
      vertices: [
        const LatLng(38.991151, -76.939086),
        const LatLng(38.991272, -76.939006),
        const LatLng(38.991393, -76.939017),
        const LatLng(38.991393, -76.938839),
        const LatLng(38.991889, -76.938850),
        const LatLng(38.991894, -76.938652),
        const LatLng(38.992302, -76.938636),
        const LatLng(38.992302, -76.939092),
        const LatLng(38.992110, -76.939097),
        const LatLng(38.992110, -76.939296),
        const LatLng(38.992231, -76.939296),
        const LatLng(38.992227, -76.939634),
        const LatLng(38.992102, -76.939645),
        const LatLng(38.992077, -76.940133),
        const LatLng(38.991389, -76.940112),
        const LatLng(38.991381, -76.939902),
        const LatLng(38.991260, -76.939902),
        const LatLng(38.991222, -76.940305),
        const LatLng(38.990993, -76.940326),
        const LatLng(38.990980, -76.939822),
        const LatLng(38.991131, -76.939526),
      ],
    ),
    UMDBuilding(
      officialName: "Animal Care Storage Facility",
      validMatches: ["Animal Care Storage Facility"],
      vertices: [
        const LatLng(38.991543, -76.938341),
        const LatLng(38.991731, -76.938201),
        const LatLng(38.991823, -76.938212),
        const LatLng(38.991973, -76.938357),
        const LatLng(38.991598, -76.938567),
      ],
    ),
    UMDBuilding(
      officialName: "Technology Advancement Building",
      validMatches: ["Technology Advancement Building"],
      vertices: [
        const LatLng(38.992406, -76.938357),
        const LatLng(38.992582, -76.938352),
        const LatLng(38.992590, -76.938873),
        const LatLng(38.992398, -76.938873),
      ],
    ),
    UMDBuilding(
      officialName: "Neutral Buoyancy Research Building",
      validMatches: ["Neutral Buoyancy Research Building"],
      vertices: [
        const LatLng(38.992769, -76.938851),
        const LatLng(38.993019, -76.938851),
        const LatLng(38.993023, -76.939119),
        const LatLng(38.992761, -76.939108),
      ],
    ),
    UMDBuilding(
      officialName: "Manufacturing Building",
      validMatches: ["Manufacturing Building"],
      vertices: [
        const LatLng(38.992719, -76.939216),
        const LatLng(38.992994, -76.939200),
        const LatLng(38.992994, -76.939656),
        const LatLng(38.992723, -76.939656),
      ],
    ),
    UMDBuilding(
      officialName: "Institute for Physical Science and Technology",
      validMatches: ["Institute for Physical Science and Technology"],
      vertices: [
        const LatLng(38.990734, -76.940889),
        const LatLng(38.991110, -76.940889),
        const LatLng(38.991106, -76.941055),
        const LatLng(38.990739, -76.941045),
      ],
    ),
    UMDBuilding(
      officialName: "Regents Drive Parking Garage",
      validMatches: ["Regents Drive Parking Garage",
        "Regents Garage",
        "Regents Drive Garage",
        "Regents",
      ],
      vertices: [
        const LatLng(38.989204, -76.940975),
        const LatLng(38.989859, -76.940948),
        const LatLng(38.990297, -76.941512),
        const LatLng(38.990280, -76.941946),
        const LatLng(38.989296, -76.941952),
        const LatLng(38.989171, -76.941791),
      ],
    ),
    UMDBuilding(
      officialName: "Plant Science Building",
      validMatches: ["Plant Science Building",
        "Plant Sciences Building",
      ],
      vertices: [
        const LatLng(38.988541, -76.940830),
        const LatLng(38.988933, -76.940857),
        const LatLng(38.988912, -76.941925),
        const LatLng(38.988666, -76.941941),
        const LatLng(38.988633, -76.941791),
        const LatLng(38.988646, -76.941104),
        const LatLng(38.988533, -76.941088),
      ],
    ),
    UMDBuilding(
      officialName: "Geology Building",
      validMatches: ["Geology Building",
        "Geology Hall",
        "Geo Building",
        "Geo Hall",
      ],
      vertices: [
        const LatLng(38.987970, -76.940830),
        const LatLng(38.988383, -76.940841),
        const LatLng(38.988383, -76.941007),
        const LatLng(38.987945, -76.941002),
      ],
    ),
    UMDBuilding(
      officialName: "Hornbake Library",
      validMatches: ["Hornbake Library",
        "Hornbake"
      ],
      vertices: [
        const LatLng(38.987803, -76.941254),
        const LatLng(38.988500, -76.941302),
        const LatLng(38.988550, -76.941753),
        const LatLng(38.988483, -76.941823),
        const LatLng(38.987795, -76.941834),
      ],
    ),
    UMDBuilding(
      officialName: "Mckeldin Library",
      validMatches: ["McKeldin",
        "McKeldin Library",
      ],
      vertices: [
        const LatLng(38.992452, -76.945536),
        const LatLng(38.985716, -76.945502),
        const LatLng(38.985641, -76.944671),
        const LatLng(38.986275, -76.944759),
      ],
    ),
    UMDBuilding(
      officialName: "Jimenez Hall",
      validMatches: ["Jimenez",
        "Jimenez Hall",
      ],
      vertices: [
        const LatLng(38.986650, -76.944816),
        const LatLng(38.986659, -76.944356),
        const LatLng(38.986955, -76.944828),
        const LatLng(38.986946, -76.944345),
      ],
    ),
    UMDBuilding(
      officialName: "H. J. Patterson Hall",
      validMatches: ["H. J. Patterson", 
        "HJ Patterson Hall",
        "HJ Patterson",
        "H. J. Patterson Hall"
      ],
      vertices: [
        const LatLng(38.986798,-76.944085),
        const LatLng(38.986810,-76.943176),
        const LatLng(38.987364,-76.943155),
        const LatLng(38.987359,-76.944034),
      ],
    ),
    UMDBuilding(
      officialName: "Edward St. Johns Learning and Teaching Center",
      validMatches: ["ESJ", 
        "ESJ Hall",
        "Edward St. Johns",
        "Edward St. Johns Learning and Teaching Center"
      ],
      vertices: [
        const LatLng(38.987392,-76.942259),
        const LatLng(38.986810,-76.943176),
        const LatLng(38.987364,-76.943155),
        const LatLng(38.987359,-76.944034),
      ],
    ),
    UMDBuilding(
      officialName: "Memorial Chapel",
      validMatches: ["Memorial Field Chapel", 
        "Chapel",
        "Memorial Chapel"
      ],
      vertices: [
        const LatLng(38.984258,-76.941354),
        const LatLng(38.984037,-76.941306),
        const LatLng(38.984032,-76.940464),
        const LatLng(38.984315,-76.940488),
      ],
    ),
  ];

  // Ray casting algorithm adapted from https://gist.github.com/aidenprice/971e10c13c82dd73c9fc <-- python and uses a bit of a different approach
  bool isPointInPolygon(LatLng point, List<LatLng> vertices) {
    bool isInside = false;
    int j = vertices.length - 1;

    for (int i = 0; i < vertices.length; i++) {
      if (vertices[i].longitude < point.longitude && vertices[j].longitude >= point.longitude ||
          vertices[j].longitude < point.longitude && vertices[i].longitude >= point.longitude) {
        if (vertices[i].latitude + (point.longitude - vertices[i].longitude) /
            (vertices[j].longitude - vertices[i].longitude) *
            (vertices[j].latitude - vertices[i].latitude) < point.latitude) {
          isInside = !isInside;
        }
      }
      j = i;
    }

    return isInside;
  }

  // Credit to https://www.geeksforgeeks.org/program-distance-two-points-earth/ for this function
  double calculateDistance(LatLng start, LatLng end) {
    double lat1 = start.latitude * (pi / 180); // to radians
    double lat2 = end.latitude * (pi / 180);
    double lon1 = start.longitude * (pi / 180);
    double lon2 = end.longitude * (pi / 180);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = pow(sin(dLat / 2), 2)
        + cos(lat1) * cos(lat2)
        * pow(sin(dLon / 2), 2);

    double c = 2 * asin(sqrt(a));

    const int r = 6371000; // in meters

    return r * c;
  }

  // Get the building a user is currently in (if any)
  UMDBuilding? getCurrentBuilding(LatLng userLocation) {
    for (var building in buildings) {
      if (isPointInPolygon(userLocation, building.vertices)) {
        return building;
      }
    }
    return null;
  }

  // Returns buildings within radiusMeters
  List<String> getNearbyBuildings(LatLng userLocation, double radiusMeters) {
    List<String> nearbyBuildings = [];
    
    for (var building in buildings) {
      // Check if any vertex of the building is within the radius
      for (var vertex in building.vertices) {
        if (calculateDistance(userLocation, vertex) <= radiusMeters) {
          nearbyBuildings.add(building.officialName);
          break;
        }
      }
    }
    
    return nearbyBuildings;
  }
   // Returns the closest building
  UMDBuilding getClosestBuilding(LatLng userLocation) {
    UMDBuilding? closestBuilding;
    double minDistance = double.infinity;
    //int i = 0;
    for (var building in buildings) {
      //print("Checking: ${building.officialName}");
      double buildingMinDistance = double.infinity;
      for (var vertex in building.vertices) {
        double distance = calculateDistance(userLocation, vertex);
        //i++;
        //print("$i: Distance = ${distance}, point = (${vertex.latitude}, ${vertex.longitude})");
        if (distance < buildingMinDistance) {
          buildingMinDistance = distance;
        }
      }

      if (buildingMinDistance < minDistance) {
        //print("New closest building: ${building.officialName}");
        minDistance = buildingMinDistance;
        closestBuilding = building;
      }
    }

    return closestBuilding!;
  }

}