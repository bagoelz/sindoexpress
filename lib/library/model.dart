import 'package:flutter/material.dart';

class UserData {
  String username;
  String password;

  UserData({this.username, this.password});
}

class ChangePassword {
  String password,newpassword,repeatpassword;
  ChangePassword({this.password,this.newpassword,this.repeatpassword});
}

class UserReg {
  String username, email, bank_account,bank_account_holder, phone,bank_id;
  int ovoNumber;

  UserReg({this.username, this.email, this.bank_id, this.phone, this.bank_account, this.bank_account_holder, this.ovoNumber});

}

class DataResi{
  String masuk,jumlah,osatuan,barang,resi,pengirim,kontainer,kapal,etd,eta,atd,ata,dt;

String get tglMasuk => masuk;
String get qty => jumlah;
String get satuan => osatuan;
String get namaBarang => barang;
String get noResi => resi;
String get namaPengirim => pengirim;
String get noKontainer => kontainer;
String get namaKapal => kapal;
String get tglEtd => etd;
String get tglEta => eta;
String get tglAtd => atd;
String get tglAta => ata;
String get tglDt => dt;

DataResi({
  this.masuk,this.jumlah,this.osatuan,this.barang,this.resi,this.pengirim,
  this.kontainer,this.kapal,this.etd,this.eta,this.atd,this.ata,this.dt,
});

  DataResi.map(dynamic data){
    this.masuk = data['tgl_lpb'];
    this.jumlah = data['qty'];
    this.osatuan = data['satuan'];
    this.barang = data['ket_det'];
    this.resi = data['nobar'];
    this.pengirim = data['pengirim_nm'];
    this.kontainer = data['no_kontainerl'];
    this.kapal = data['kapal'];
    this.etd = data['etd'];
    this.eta = data['eta'];
    this.atd = data['td'];
    this.ata = data['ta'];

  }
}
// "ref": "A.52989",
//         "pengirim_nm": "BHINEKA",
//         "notl": "BO/KLK/1910/02661",
//         "nojnl": "BO/KLK/1910/02661",
//         "nobar": "C1925479-705",
//         "satuan": "DOS",
//         "nm_sub": "TFI (CV.FAJAR SENTOSA)",
//         "alamat_kirim2": "KUPANG",
//         "tgl_lpb": "29/10/2019",
//         "coli": "1",
//         "ket_det": "ANTANGIN",
//         "lpbf_tgl": "2019-10-29 00:00:00",
//         "notld": "BO/KLK/1910/02661.008",
//         "muat": "1",
//         "no_kontainer": "",
//         "no_kontainerl": "MRLU 235.769.9",
//         "kapal": "MERATUS WAKATOBI",
//         "no_konosemen": "INV-SBY-1910-4028.A",
//         "nobpb": "BPB-SBY-1910-5285",
//         "etd": "30/10/2019",
//         "eta": "04/11/2019",
//         "td": "30/10/2019",
//         "ta": "02/11/2019",
//         "tgl_st": "11/11/2019",
//         "notlm": "",
//         "status": "1",
//         "jam_st": "09:30",
//         "nm_terima": "PARAF STEMPEL",
//         "sopir_st": "RANDI SIP 16",
//         "kon": "MRLU 235.769.9",
//         "sort": "2019-10-29 00:00:00BO/KLK/1910/02661TFI (CV.FAJAR SENTOSA)",
//         "qty": "1"
//     },
//     {
//         "ref": "A.52989",
//         "pengirim_nm": "BHINEKA",
//         "notl": "BO/KLK/1910/02661",
//         "nojnl": "BO/KLK/1910/02661",
//         "nobar": "C1925479-705",
//         "satuan": "DOS",
//         "nm_sub": "TFI (CV.FAJAR SENTOSA)",
//         "alamat_kirim2": "KUPANG",
//         "tgl_lpb": "29/10/2019",
//         "coli": "1",
//         "ket_det": "CAMPURAN",
//         "lpbf_tgl": "2019-10-29 00:00:00",
//         "notld": "BO/KLK/1910/02661.006",
//         "muat": "1",
//         "no_kontainer": "",
//         "no_kontainerl": "MRLU 235.769.9",
//         "kapal": "MERATUS WAKATOBI",
//         "no_konosemen": "INV-SBY-1910-4028.A",
//         "nobpb": "BPB-SBY-1910-5285",
//         "etd": "30/10/2019",
//         "eta": "04/11/2019",
//         "td": "30/10/2019",
//         "ta": "02/11/2019",
//         "tgl_st": "11/11/2019",
//         "notlm": "",
//         "status": "1",
//         "jam_st": "09:30",
//         "nm_terima": "PARAF STEMPEL",
//         "sopir_st": "RANDI SIP 16",
//         "kon": "MRLU 235.769.9",
//         "sort": "2019-10-29 00:00:00BO/KLK/1910/02661TFI (CV.FAJAR SENTOSA)",
//         "qty": "1"
class NoResi{
  String resi;
  NoResi({
  this.resi,
  });
}

class Pelabuhan {
  int id,enabled;
  String nama;

  Pelabuhan({
    this.id,
    this.nama,
    this.enabled,
  });

  Pelabuhan.map(dynamic data){
    this.id = data['id'];
    this.nama = data['name'];
    this.enabled= data['is_enabled'];
  }
}

class DataSchedule{
  int id,asal,tujuan,tglberangkat,tgltiba,enabled,directRoute;
  DataKapal dataKapal;
  String namapelabuhanasal, namapelabuhantujuan;
  DataSchedule({
    this.id,
    this.asal,
    this.tujuan,
    this.tglberangkat,
    this.tgltiba,
    this.enabled,
    this.directRoute,
  });

  DataSchedule.map(dynamic data){
    this.id = data['id'];
    this.asal=data['departure_port_id'];
    this.tujuan=data['destination_port_id'];
    this.tglberangkat=data['departure_date'];
    this.tgltiba=data['arrival_date'];
    this.enabled=data['is_enabled'];
    this.directRoute=data['is_direct_route'];
    this.dataKapal = DataKapal.map(data['ship']);
    this.namapelabuhanasal="";
    this.namapelabuhantujuan="";
    
  }
}

class Newsdata {
  String title, slug, picture,content;

  Newsdata({
    this.title,
    this.slug,
    this.picture,
    this.content,
  });

  Newsdata.map(dynamic data){
    title = data['title'];
    slug = data['slug'];
    picture = data['picture'];
    content=data['content'];
  }

}


class DataKapal{
  int id,enabled;
  String name;
  DataKapal({
    this.id,
    this.enabled,
    this.name
  });
  DataKapal.map(dynamic data){
    this.id = data['id'];
    this.name = data['name'];
    this.enabled = data['is_enabled'];
  }

}
class DataLogin{
  String kode,nama,alamat,kota,hp;
  DataLogin({
    this.kode,
    this.nama,
    this.alamat,
    this.kota,
    this.hp,
  });
}

class DataSlide{
  String picture,caption,url;
  int published;

  DataSlide({
    this.picture,this.caption,this.published,this.url,
  });

  DataSlide.map(dynamic data){
    this.picture = data['picture'];
    this.caption = data['caption'];
    this.published = data['is_published'];
    this.url =data['picture_url'];
  }
}

class DataGallery{
  int id;
  String picture,caption;
  DataGallery({
    this.id,
    this.picture,
    this.caption
  });
 DataGallery.map(dynamic data){
   this.id=data['id'];
   this.picture=data['picture'];
   this.caption=data['caption'];
 }
}

class Datainvoice{
  String kdac,nota,kdSub,no,tgl,tglJt,kdRute,pc,noRef,namaSub,tglJtA,tglA,debet,kredit,sisa,noJnl,jt,bulan;
  int day;
  Datainvoice({
    this.kdac,
    this.nota,
    this.kdSub,
    this.no,
    this.tgl,
    this.tglJt,
    this.kdRute,
    this.pc,
    this.noRef,
    this.namaSub,
    this.tglJtA,
    this.tglA,
    this.debet,
    this.kredit,
    this.sisa,
    this.noJnl,
    this.jt,
    this.day,
    this.bulan,
     });
    Datainvoice.map(dynamic data){
    this.kdac=data['kdac'];
    this.nota=data['nota'];
    this.kdSub=data['kd_sub'];
    this.no=data['no'];
    this.tgl=data['tgl'];
    this.tglJt=data['tgl_jt'];
    this.kdRute=data['kd_rute'];
    this.pc=data['pc'];
    this.noRef=data['no_ref'];
    this.namaSub=data['nm_sub'];
    this.tglJtA=data['tgl_jt_a'];
    this.tglA=data['tgl_a'];
    this.debet=data['debet'];
    this.kredit=data['credit'];
    this.sisa=data['sisa'];
    this.noJnl=data['nojnl'];
    this.jt=data['jt'];
    this.day=data['day'];
    this.bulan=data['bulan'];
    }
       
 
}