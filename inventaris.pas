program Pengelola_Inventaris_Barang;
uses crt;

const MAX = 100;  // Batas maksimal barang

type RBarang = record  
  nama: string;
  kode: string;
  stok: integer;
end;

var barang: array[1..MAX] of RBarang;  // Array penyimpan data
    n: integer = 0;  
    pilihan: integer;

// Cari barang berdasarkan kode
function cariBarang(kode: string): integer;
var i: integer;
begin
  for i := 1 to n do
    if barang[i].kode = kode then
    begin
      cariBarang := i;
      exit;
    end;
  cariBarang := 0;
end;

// Tambah barang baru ke inventaris
procedure tambahBarang;
begin
  if n >= MAX then
  begin
    writeln('Inventaris penuh!');
    readln;
    exit;
  end;
  
  n := n + 1;
  write('Kode barang: '); readln(barang[n].kode);
  
  // Validasi kode unik
  if cariBarang(barang[n].kode) < n then
  begin
    writeln('Kode sudah ada!');
    n := n - 1;
    readln;
    exit;
  end;
  
  write('Nama barang: '); readln(barang[n].nama);
  write('Stok awal: '); readln(barang[n].stok);
  writeln('Barang berhasil ditambahkan!');
  readln;
end;

// Tambah atau kurangi stok barang
procedure ubahStok(operasi: string);
var kode: string; indikator, jumlah: integer;
begin
  write('Kode barang: '); readln(kode);
  indikator := cariBarang(kode);
  
  if indikator = 0 then
  begin
    writeln('Barang tidak ditemukan!');
    readln;
    exit;
  end;
  
  write('Jumlah: '); readln(jumlah);
  
  if operasi = 'tambah' then
  begin
    barang[indikator].stok := barang[indikator].stok + jumlah;
    writeln('Stok berhasil ditambahkan!');
  end
  else if operasi = 'kurang' then
  begin
    // Cek stok cukup
    if jumlah > barang[indikator].stok then
    begin
      writeln('Stok tidak mencukupi!');
      readln;
      exit;
    end;
    
    barang[indikator].stok := barang[indikator].stok - jumlah;
    writeln('Stok berhasil dikurangi!');
    
    // Peringatan stok habis
    if barang[indikator].stok = 0 then
      writeln('PERINGATAN: Stok habis!');
  end;
  
  readln;
end;

// Tampilkan semua barang dalam inventaris
procedure tampilkanSemua;
var i: integer;
begin
  if n = 0 then
  begin
    writeln('Inventaris kosong!');
    readln;
    exit;
  end;
  
  writeln('=== DAFTAR BARANG ===');
  for i := 1 to n do
  begin
    write(i:2, '. ', barang[i].kode:8, ' - ');
    write(barang[i].nama:20, ' : ', barang[i].stok:4);
    if barang[i].stok = 0 then write(' (HABIS)');
    writeln;
  end;
  readln;
end;

// Cari dan tampilkan barang dengan stok terbanyak
procedure stokTerbanyak;
var i, maxindikator, maxStok: integer;
begin
  if n = 0 then
  begin
    writeln('Inventaris kosong!');
    readln;
    exit;
  end;
  
  maxStok := barang[1].stok;
  maxindikator := 1;
  
  for i := 2 to n do
  begin
    if barang[i].stok > maxStok then
    begin
      maxStok := barang[i].stok;
      maxindikator := i;
    end;
  end;
  
  writeln('Stok terbanyak: ', barang[maxindikator].nama);
  writeln('Kode: ', barang[maxindikator].kode);
  writeln('Jumlah: ', barang[maxindikator].stok);
  readln;
end;

// Tampilkan barang dengan stok (<=) dan barang habis
procedure barangHampirHabis;
var i: integer; ada: boolean;
begin
  if n = 0 then
  begin
    writeln('Inventaris kosong!');
    readln;
    exit;
  end;
  
  ada := false;
  writeln('Barang dengan stok <= 5:');
  
  for i := 1 to n do
  begin
    if (barang[i].stok > 0) and (barang[i].stok <= 5) then
    begin
      writeln('- ', barang[i].nama, ' (', barang[i].stok, ')');
      ada := true;
    end;
  end;
  
  if not ada then writeln('Tidak ada');
  
  writeln;
  writeln('Barang yang habis:');
  ada := false;
  for i := 1 to n do
  begin
    if barang[i].stok = 0 then
    begin
      writeln('- ', barang[i].nama);
      ada := true;
    end;
  end;
  
  if not ada then writeln('Tidak ada');
  readln;
end;

// Tampilkan menu utama
procedure tampilkanMenu;
begin
  clrscr;
  writeln('=== PENGELOLAAN INVENTARIS ===');
  writeln('1. Tambah barang baru');
  writeln('2. Tambah stok');
  writeln('3. Kurangi stok');
  writeln('4. Tampilkan semua');
  writeln('5. Stok terbanyak');
  writeln('6. Barang hampir habis');
  writeln('7. Keluar');
  write('Pilihan: ');
end;

begin  // Program utama - loop menu
  repeat
    tampilkanMenu;
    readln(pilihan);
    
    case pilihan of
      1: tambahBarang;
      2: ubahStok('tambah');
      3: ubahStok('kurang');
      4: tampilkanSemua;
      5: stokTerbanyak;
      6: barangHampirHabis;
    end;
    
  until pilihan = 7;
  
  writeln('Program selesai.');

end.

