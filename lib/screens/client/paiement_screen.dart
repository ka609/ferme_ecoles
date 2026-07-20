import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/commande_model.dart';
import '../../providers/paiement_provider.dart';

class PaiementScreen extends StatefulWidget {
  final Commande commande;

  const PaiementScreen({
    super.key,
    required this.commande,
  });

  @override
  State<PaiementScreen> createState() => _PaiementScreenState();
}

class _PaiementScreenState extends State<PaiementScreen> {
  String _moyen = "Mobile Money";

  final TextEditingController _referenceController = TextEditingController();

  final List<String> _moyens = [
    "Mobile Money",
    "Espèces",
    "Virement",
  ];

  bool _isSubmitting = false;

  // ---------------------------------------------------------------------
  // Logique métier : INCHANGÉE
  // ---------------------------------------------------------------------

  Future<void> _validerPaiement() async {
    setState(() {
      _isSubmitting = true;
    });

    final success = await context.read<PaiementProvider>().createPaiement(
          commandeId: widget.commande.id,
          montant: widget.commande.montantTotal,
          moyen: _moyen,
          reference: _referenceController.text.trim().isEmpty
              ? null
              : _referenceController.text.trim(),
        );

    setState(() {
      _isSubmitting = false;
    });

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Paiement enregistré avec succès"),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.read<PaiementProvider>().error ?? "Erreur paiement",
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _referenceController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------
  // UI
  // ---------------------------------------------------------------------

  IconData _iconPourMoyen(String moyen) {
    switch (moyen) {
      case "Mobile Money":
        return Icons.smartphone_outlined;
      case "Espèces":
        return Icons.payments_outlined;
      case "Virement":
        return Icons.account_balance_outlined;
      default:
        return Icons.payment_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isWide = MediaQuery.sizeOf(context).width >= 700;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        title: const Text("Paiement"),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 24 : 16,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRecapCard(context),
                  const SizedBox(height: 24),
                  _buildMoyensSection(context),
                  const SizedBox(height: 24),
                  _buildReferenceField(context),
                  const SizedBox(height: 32),
                  _buildValiderButton(context),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---- Récapitulatif de la commande --------------------------------------

  Widget _buildRecapCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withOpacity(0.75),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.receipt_long_outlined,
                color: Colors.white, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Commande ${widget.commande.numero}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  "${widget.commande.montantTotal.toStringAsFixed(0)} FCFA",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Montant total à régler",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.85),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---- Section générique (carte avec en-tête), même style que le dashboard --

  Widget _sectionCard({
    required BuildContext context,
    required String title,
    IconData? icon,
    required Widget child,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 18, color: colorScheme.primary),
                ),
                const SizedBox(width: 10),
              ],
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  // ---- Choix du moyen de paiement -----------------------------------------

  Widget _buildMoyensSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context: context,
      title: "Choisir le moyen de paiement",
      icon: Icons.credit_card_outlined,
      child: Column(
        children: _moyens.map((moyen) {
          final selected = moyen == _moyen;

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Material(
              color: selected
                  ? colorScheme.primary.withOpacity(0.08)
                  : colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  setState(() {
                    _moyen = moyen;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selected
                          ? colorScheme.primary
                          : colorScheme.outlineVariant.withOpacity(0.4),
                      width: selected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: selected
                              ? colorScheme.primary.withOpacity(0.15)
                              : colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          _iconPourMoyen(moyen),
                          size: 18,
                          color: selected
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          moyen,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                        ),
                      ),
                      Radio<String>(
                        value: moyen,
                        groupValue: _moyen,
                        onChanged: (value) {
                          setState(() {
                            _moyen = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ---- Référence de transaction -------------------------------------------

  Widget _buildReferenceField(BuildContext context) {
    return _sectionCard(
      context: context,
      title: "Référence (optionnel)",
      icon: Icons.tag_outlined,
      child: TextField(
        controller: _referenceController,
        decoration: InputDecoration(
          labelText: "Référence transaction",
          hintText: "Ex: TX123456",
          prefixIcon: const Icon(Icons.confirmation_number_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // ---- Bouton de validation ------------------------------------------------

  Widget _buildValiderButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: _isSubmitting ? null : _validerPaiement,
        icon: _isSubmitting
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.payment),
        label: Text(
          _isSubmitting ? "Validation..." : "Valider le paiement",
        ),
      ),
    );
  }
}