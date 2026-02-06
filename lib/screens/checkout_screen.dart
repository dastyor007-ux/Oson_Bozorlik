import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedDateIndex = 0;
  int? _selectedTimeIndex = 0;

  List<String> get _dateLabels {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    return [
      'Сегодня (${_formatDate(now)})',
      'Завтра (${_formatDate(tomorrow)})',
    ];
  }

  final List<String> _timeSlots = const [
    '09:00 - 12:00',
    '12:00 - 15:00',
    '16:00 - 18:00',
    '18:00 - 20:00',
  ];

  DateTime get _tashkentNow {
    return DateTime.now().toUtc().add(const Duration(hours: 5));
  }

  DateTime _slotStartToday(int index) {
    final now = _tashkentNow;
    final startHour = _timeSlotStartHour(index);
    return DateTime(now.year, now.month, now.day, startHour);
  }

  int _timeSlotStartHour(int index) {
    switch (index) {
      case 0:
        return 9;
      case 1:
        return 12;
      case 2:
        return 16;
      case 3:
        return 18;
      default:
        return 9;
    }
  }

  bool _isSlotAvailable(int index) {
    if (_selectedDateIndex != 0) return true;
    final now = _tashkentNow;
    final slotStart = _slotStartToday(index);
    return slotStart.isAfter(now) || slotStart.isAtSameMomentAs(now);
  }

  int? _nextAvailableSlotIndex() {
    for (var i = 0; i < _timeSlots.length; i++) {
      if (_isSlotAvailable(i)) return i;
    }
    return null;
  }

  void _selectDate(int index) {
    setState(() {
      _selectedDateIndex = index;
      if (_selectedDateIndex == 0) {
        _selectedTimeIndex = _nextAvailableSlotIndex();
      } else if (_selectedTimeIndex == null) {
        _selectedTimeIndex = 0;
      }
    });
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day.$month';
  }

  @override
  void initState() {
    super.initState();
    _selectedTimeIndex = _nextAvailableSlotIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildAddressSection(),
                    const SizedBox(height: 12),
                    _buildDateSection(),
                    const SizedBox(height: 12),
                    _buildTimeSection(),
                    const SizedBox(height: 12),
                    _buildPaymentSection(),
                    const SizedBox(height: 24),
                  ]
                      .animate(interval: 60.ms)
                      .fadeIn(duration: 300.ms)
                      .slideY(begin: 0.05, end: 0),
                ),
              ),
              _buildBottomBar(context, cart),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            const SizedBox(width: 8),
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.lightGreen.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.darkGreen,
                  size: 16,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const Expanded(
              child: Text(
                'Оформление заказа',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(width: 48),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.paleGreen,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: AppColors.accentGreen),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.lightGreen.withValues(alpha: 0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildAddressSection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Адрес доставки', Icons.location_on_outlined),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              // TODO: Open address selection
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.paleGreen.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.lightGreen.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.place_outlined,
                    size: 18,
                    color: AppColors.darkGreen,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Выберите адрес доставки',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Дата доставки', Icons.calendar_today_outlined),
          const SizedBox(height: 12),
          Row(
            children: List.generate(_dateLabels.length, (index) {
              final isSelected = _selectedDateIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(index),
                  child: Container(
                    margin: EdgeInsets.only(right: index == 0 ? 8 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.accentGreen
                          : AppColors.paleGreen,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      _dateLabels[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? AppColors.white
                            : AppColors.darkGreen,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSection() {
    final hasAvailableSlotsToday = _selectedDateIndex != 0
        ? true
        : _timeSlots.asMap().keys.any(_isSlotAvailable);

    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Время доставки', Icons.access_time_outlined),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_timeSlots.length, (index) {
              final isSelected = _selectedTimeIndex == index;
              final isAvailable = _isSlotAvailable(index);
              return GestureDetector(
                onTap: isAvailable
                    ? () => setState(() => _selectedTimeIndex = index)
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accentGreen
                        : isAvailable
                            ? AppColors.paleGreen
                            : AppColors.divider.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _timeSlots[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? AppColors.white
                          : isAvailable
                              ? AppColors.darkGreen
                              : AppColors.textSecondary.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              );
            }),
          ),
          if (!hasAvailableSlotsToday) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: AppColors.textSecondary.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'На сегодня доступных интервалов нет — выберите дату завтра.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Оплата', Icons.payments_outlined),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.paleGreen.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.lightGreen.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.local_shipping_outlined,
                  size: 18,
                  color: AppColors.darkGreen,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Оплата при получении',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.accentGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 14,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, CartProvider cart) {
    final canPlaceOrder =
        cart.items.isNotEmpty &&
        !cart.hasUnavailableItems &&
        _selectedTimeIndex != null;
    final total = cart.totalPrice.toInt();

    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          if (cart.hasUnavailableItems) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade100),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 18,
                    color: Colors.red.shade400,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Удалите недоступные товары из корзины',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.red.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: canPlaceOrder
                  ? () {
                      // TODO: Place order
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentGreen,
                disabledBackgroundColor: AppColors.divider,
                foregroundColor: AppColors.white,
                disabledForegroundColor: AppColors.textSecondary,
                elevation: canPlaceOrder ? 4 : 0,
                shadowColor: AppColors.accentGreen.withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Оформить заказ на $total SOM',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
