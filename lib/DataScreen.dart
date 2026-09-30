import 'package:flutter/material.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  // 1. Match Format Selection: 'ODI' or 'TEST' (Only one selectable)
  String _selectedFormat = 'ODI';

  // 2. Teams Text Controllers
  final TextEditingController _hostTeamController =
      TextEditingController(text: 'India');
  final TextEditingController _visitorTeamController =
      TextEditingController(text: 'Australia');

  // 3. Team Selection: 'Host Team' or 'Visitor Team' (Only one selectable)
  String _selectedTeam = 'Host Team';

  // 4. Bat / Bowl Selection: 'Bat' or 'Bowl' (Only one selectable)
  String _selectedDecision = 'Bat';

  // 5. Match Stats: Overs, Runs, Wickets
  double _overs = 15.2;
  int _runs = 142;
  int _wickets = 3;

  @override
  void dispose() {
    _hostTeamController.dispose();
    _visitorTeamController.dispose();
    super.dispose();
  }

  // Helper method to get readable team name based on selection
  String get _selectedTeamDisplayName {
    if (_selectedTeam == 'Host Team') {
      return _hostTeamController.text.isNotEmpty
          ? _hostTeamController.text
          : 'Host Team';
    } else {
      return _visitorTeamController.text.isNotEmpty
          ? _visitorTeamController.text
          : 'Visitor Team';
    }
  }

  @override
  Widget build(BuildContext context) {
    final hostName = _hostTeamController.text.isNotEmpty
        ? _hostTeamController.text
        : 'Host Team';
    final visitorName = _visitorTeamController.text.isNotEmpty
        ? _visitorTeamController.text
        : 'Visitor Team';

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "Cricket Match Data",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          // Live Text Badge in AppBar
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.red.shade900.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.redAccent, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  "LIVE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Live Summary Banner Card ---
            _buildLiveScoreCard(hostName, visitorName),
            const SizedBox(height: 20),

            // --- SECTION 1: Match Format Box Grid View (ODI / TEST) ---
            _buildSectionHeader("Match Format (Select One)", Icons.sports_cricket),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.2,
              children: [
                _buildFormatSelectableBox("ODI", "50 Overs Match", Icons.timer),
                _buildFormatSelectableBox("TEST", "5 Days Match", Icons.shield),
              ],
            ),
            const SizedBox(height: 24),

            // --- SECTION 2: Teams Box Grid View (Host Team / Visitor Team) ---
            _buildSectionHeader("Teams", Icons.groups),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.25,
              children: [
                _buildTeamInputBox("Host Team", _hostTeamController, Colors.blue.shade800),
                _buildTeamInputBox("Visitor Team", _visitorTeamController, Colors.orange.shade800),
              ],
            ),
            const SizedBox(height: 24),

            // --- SECTION 3: Select Team Box Grid View (Host Team / Visitor Team) ---
            _buildSectionHeader("Select Team Option (Select One)", Icons.how_to_reg),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.0,
              children: [
                _buildTeamSelectableBox("Host Team", hostName, Icons.home),
                _buildTeamSelectableBox("Visitor Team", visitorName, Icons.flight_takeoff),
              ],
            ),
            const SizedBox(height: 24),

            // --- SECTION 4: Decision Box Grid View (Bat / Bowl) ---
            _buildSectionHeader("Decision Option (Select One)", Icons.sports),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.0,
              children: [
                _buildDecisionSelectableBox("Bat", Icons.sports_cricket),
                _buildDecisionSelectableBox("Bowl", Icons.sports_baseball),
              ],
            ),
            const SizedBox(height: 24),

            // --- SECTION 5: Score & Stats Box Grid View (Overs, Runs, Wickets) ---
            _buildSectionHeader("Match Stats", Icons.analytics),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.82,
              children: [
                _buildStatBox(
                  title: "Overs",
                  value: _overs.toStringAsFixed(1),
                  icon: Icons.access_time,
                  color: Colors.indigo,
                  onIncrement: () {
                    setState(() {
                      double ball = (_overs * 10).round() % 10;
                      double over = _overs.floorToDouble();
                      if (ball >= 5) {
                        _overs = over + 1.0;
                      } else {
                        _overs = double.parse((_overs + 0.1).toStringAsFixed(1));
                      }
                    });
                  },
                  onDecrement: () {
                    if (_overs > 0) {
                      setState(() {
                        double ball = (_overs * 10).round() % 10;
                        double over = _overs.floorToDouble();
                        if (ball == 0) {
                          _overs = double.parse((over - 1 + 0.5).toStringAsFixed(1));
                        } else {
                          _overs = double.parse((_overs - 0.1).toStringAsFixed(1));
                        }
                        if (_overs < 0) _overs = 0.0;
                      });
                    }
                  },
                ),
                _buildStatBox(
                  title: "Runs",
                  value: "$_runs",
                  icon: Icons.scoreboard,
                  color: Colors.green.shade800,
                  onIncrement: () {
                    setState(() {
                      _runs++;
                    });
                  },
                  onDecrement: () {
                    if (_runs > 0) {
                      setState(() {
                        _runs--;
                      });
                    }
                  },
                ),
                _buildStatBox(
                  title: "Wickets",
                  value: "$_wickets",
                  icon: Icons.cancel_outlined,
                  color: Colors.red.shade800,
                  onIncrement: () {
                    if (_wickets < 10) {
                      setState(() {
                        _wickets++;
                      });
                    }
                  },
                  onDecrement: () {
                    if (_wickets > 0) {
                      setState(() {
                        _wickets--;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildLiveScoreCard(String hostName, String visitorName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _selectedFormat,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
              const Row(
                children: [
                  Icon(Icons.circle, color: Colors.redAccent, size: 10),
                  SizedBox(width: 4),
                  Text(
                    "LIVE SCOREBOARD",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "$hostName  vs  $visitorName",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "$_runs / $_wickets",
            style: const TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.w900,
              fontSize: 32,
            ),
          ),
          Text(
            "Overs: ${_overs.toStringAsFixed(1)}",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(color: Colors.white24, height: 20),
          Text(
            "$_selectedTeamDisplayName elected to $_selectedDecision",
            style: TextStyle(
              color: Colors.greenAccent.shade100,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF1B5E20)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
        ),
      ],
    );
  }

  // Format Box Item
  Widget _buildFormatSelectableBox(String format, String subtitle, IconData icon) {
    final bool isSelected = _selectedFormat == format;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedFormat = format; // Only one can be selected
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1B5E20) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF1B5E20) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.amber : const Color(0xFF1B5E20),
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      format,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: Colors.amber,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Team Input Box Item
  Widget _buildTeamInputBox(
      String label, TextEditingController controller, Color headerColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield, color: headerColor, size: 18),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: headerColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (val) {
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                isDense: true,
                hintText: "Enter $label",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Select Team Box Item
  Widget _buildTeamSelectableBox(
      String optionKey, String teamName, IconData icon) {
    final bool isSelected = _selectedTeam == optionKey;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedTeam = optionKey; // Only one can be selected
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2C5364) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF2C5364) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.amber : const Color(0xFF2C5364),
                size: 22,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      optionKey,
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    Text(
                      teamName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: Colors.amber,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Decision Select Box Item (Bat / Bowl)
  Widget _buildDecisionSelectableBox(String option, IconData icon) {
    final bool isSelected = _selectedDecision == option;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedDecision = option; // Only one can be selected
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.amber.shade800 : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.amber.shade900,
                size: 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  option,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Match Stat Box Item (Overs, Runs, Wickets)
  Widget _buildStatBox({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: color,
                ),
              ),
            ],
          ),
          FittedBox(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: color,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: onDecrement,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.remove, size: 16, color: Colors.black87),
                ),
              ),
              InkWell(
                onTap: onIncrement,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
