import 'package:flutter/material.dart';

class Receiver {
  final String id;
  final String name;
  final String? routeId;
  bool isSelected;

  Receiver({
    required this.id,
    required this.name,
    this.routeId,
    this.isSelected = false,
  });
}

class SelectReceiverDialog extends StatefulWidget {
  final Function(List<Receiver>) onSave;

  const SelectReceiverDialog({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  @override
  State<SelectReceiverDialog> createState() => _SelectReceiverDialogState();
}

class _SelectReceiverDialogState extends State<SelectReceiverDialog> {
  // Danh sách người nhận mẫu
  final List<Receiver> _receivers = [
    Receiver(id: '1', name: 'Bùi Thị Lê 3A', routeId: 'A'),
    Receiver(id: '2', name: 'Nguyễn Văn An 3B', routeId: 'B'),
    Receiver(id: '3', name: 'Nguyễn Văn Bn 3B', routeId: 'C'),
    Receiver(id: '4', name: 'Nguyễn Văn Cn 3B', routeId: 'D'),
    Receiver(id: '5', name: 'Nguyễn Văn Đn 3B', routeId: 'E'),
    Receiver(id: '6', name: 'Nguyễn Văn En 3B', routeId: 'F'),
    // Thêm dữ liệu mẫu khác
  ];

  bool _selectAll = false;
  bool _selectRouteA = false;
  bool _selectRouteB = false;
  bool _selectCustom = false;
  String _searchQuery = '';
  List<Receiver> _selectedReceivers = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSelectAll(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      _selectRouteA = false;
      _selectRouteB = false;
      _selectCustom = false;
      _selectedReceivers = value == true ? List.from(_receivers) : [];
    });
  }

  void _handleSelectRoute(String route, bool? value) {
    setState(() {
      if (route == 'A') {
        _selectRouteA = value ?? false;
      } else {
        _selectRouteB = value ?? false;
      }
      _selectAll = false;
      _selectCustom = false;

      if (value == true) {
        _selectedReceivers.addAll(
          _receivers.where((r) => r.routeId == route && !_selectedReceivers.contains(r))
        );
      } else {
        _selectedReceivers.removeWhere((r) => r.routeId == route);
      }
    });
  }

  void _handleSelectCustom(bool? value) {
    setState(() {
      _selectCustom = value ?? false;
      _selectAll = false;
      _selectRouteA = false;
      _selectRouteB = false;
      if (!_selectCustom) {
        _selectedReceivers.clear();
      }
    });
  }

  void _handleReceiverSelection(Receiver receiver, bool? selected) {
    setState(() {
      if (selected == true) {
        _selectedReceivers.add(receiver);
      } else {
        _selectedReceivers.remove(receiver);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Receiver> filteredReceivers = _receivers;
    if (_searchQuery.isNotEmpty) {
      filteredReceivers = _receivers
          .where((r) => r.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Chọn người nhận',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CheckboxListTile(
                      value: _selectAll,
                      onChanged: _handleSelectAll,
                      title: const Text('Tất cả phụ huynh'),
                    ),
                    CheckboxListTile(
                      value: _selectRouteA,
                      onChanged: (value) => _handleSelectRoute('A', value),
                      title: const Text('Phụ huynh điểm đón tuyến A'),
                    ),
                    if (_selectRouteA) ..._buildRouteReceivers('A'),
                    CheckboxListTile(
                      value: _selectRouteB,
                      onChanged: (value) => _handleSelectRoute('B', value),
                      title: const Text('Phụ huynh điểm đón tuyến B'),
                    ),
                    if (_selectRouteB) ..._buildRouteReceivers('B'),
                    CheckboxListTile(
                      value: _selectCustom,
                      onChanged: _handleSelectCustom,
                      title: const Text('Tùy chọn phụ huynh'),
                    ),
                    if (_selectCustom) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Tìm kiếm...',
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                      ),
                      ..._buildSearchResults(filteredReceivers),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedReceivers.isNotEmpty
                      ? () {
                          widget.onSave(_selectedReceivers);
                          Navigator.pop(context);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    foregroundColor: Colors.white,
                  ),
                  child:  Text('Lưu',style: TextStyle(fontSize: 16),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRouteReceivers(String route) {
    return _receivers
        .where((r) => r.routeId == route)
        .map(
          (r) => Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: CheckboxListTile(
              value: _selectedReceivers.contains(r),
              onChanged: (selected) => _handleReceiverSelection(r, selected),
              title: Text(r.name),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _buildSearchResults(List<Receiver> receivers) {
    return receivers
        .map(
          (r) => CheckboxListTile(
            value: _selectedReceivers.contains(r),
            onChanged: (selected) => _handleReceiverSelection(r, selected),
            title: Text(r.name),
          ),
        )
        .toList();
  }
}
