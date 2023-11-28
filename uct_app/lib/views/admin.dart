import 'package:flutter/material.dart';
import 'package:uct_app/components/administradores.dart';
import 'package:uct_app/components/dteadmin.dart';
import 'package:uct_app/components/dominios.dart';
import 'package:uct_app/components/citas.dart';
import 'package:uct_app/components/bloqueados.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text('Panel de Administración'),
  bottom: PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabs: const [
          Tab(text: 'Cinap'),
          Tab(text: 'Administradores'),
          Tab(text: 'Citas'),
          Tab(text: 'Dominios'),
          Tab(text: 'Bloqueados')
        ],
      ),
    ),
  ),
),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildDteAdminTab(context, editDte, deleteDte, addDte),
          buildAdminAccessTab  (editAdmin, deleteAdmin, addAdmin),
          buildCitasTab(context),
          buildDomainAccessTab (context, deleteDomain, editDominio, addDominio),
          buildBloqueadosTab(),
        ],
      ),
    );
  }
}