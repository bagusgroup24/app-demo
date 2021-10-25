part of 'pages.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference barang = firestore.collection('barang');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Home',
          style: whiteText,
        ),
        flexibleSpace: Container(
          margin: EdgeInsets.only(
            top: defaultMargin,
            right: defaultMargin,
          ),
          child: GestureDetector(
            onTap: () async {
              await AuthServices.logout();
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.logout,
                color: mainWhite,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: barang.orderBy('namaBarang').snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data.docs
                      .map(
                        (e) => BarangTile(
                          e.data()['kodeBarang'],
                          e.data()['namaBarang'],
                          e.data()['jenisBarang'],
                          onDelete: () {
                            barang.doc(e.id).delete();
                          },
                        ),
                      )
                      .toList(),
                );
              } else {
                return Text('loading');
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
      ),
    );
  }
}

class BarangTile extends StatelessWidget {
  final String kodeBarang;
  final String namaBarang;
  final String jenisBarang;
  final Function onDelete;
  final Function onUpdate;
  BarangTile(this.kodeBarang, this.namaBarang, this.jenisBarang,
      {this.onDelete, this.onUpdate});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Kode Barang     :',
                    style: blackText.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      kodeBarang,
                      style: blackText,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Selamat data berhasil dihapus!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      if (onDelete != null) onDelete();
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Nama Barang   :',
                    style: blackText.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      namaBarang,
                      style: blackText,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Jenis Barang     :',
                    style: blackText.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      jenisBarang,
                      style: blackText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class AddData extends StatelessWidget {
  final TextEditingController kodeBarang = TextEditingController();

  final TextEditingController namaBarang = TextEditingController();

  final TextEditingController jenisBarang = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference barang = firestore.collection('barang');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tambah Data',
          style: whiteText,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 40,
              child: TextField(
                controller: kodeBarang,
                decoration: InputDecoration(
                  labelText: 'kode barang',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 40,
              child: TextField(
                controller: namaBarang,
                decoration: InputDecoration(
                  labelText: 'nama barang',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              height: 40,
              child: TextField(
                controller: jenisBarang,
                decoration: InputDecoration(
                  labelText: 'jenis barang',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'Tambah Data',
                  style: whiteText.copyWith(
                    fontWeight: bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Selamat data berhasil ditambah!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  barang.add({
                    'kodeBarang': kodeBarang.text,
                    'namaBarang': namaBarang.text,
                    'jenisBarang': jenisBarang.text,
                  });

                  kodeBarang.text = '';
                  namaBarang.text = '';
                  jenisBarang.text = '';
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
