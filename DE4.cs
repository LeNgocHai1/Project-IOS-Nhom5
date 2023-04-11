/*
 * MaSV:
 * HoTen:
 * Ngay KT:
 * Lop:
 */
using System;
using System.IO;
namespace ConsoleApplication1
{
    class MonHoc
    {
        private string maMH, tenMH;
        private DateTime ngayDK;
        private int soTC;

        public string MaMH
        {
            get
            {
                return maMH;
            }

            set
            {
                maMH = value;
            }
        }

        public DateTime NgayDK
        {
            get
            {
                return ngayDK;
            }

            set
            {
                ngayDK = value;
            }
        }

        public int SoTC
        {
            get
            {
                return soTC;
            }

            set
            {
                soTC = value;
            }
        }

        public string TenMH
        {
            get
            {
                return tenMH;
            }

            set
            {
                tenMH = value;
            }
        }

        public void Doc(StreamReader sr)
        {
            string[] t = sr.ReadLine().Split('#');
            maMH = t[0];
            tenMH = t[1];
            ngayDK = DateTime.ParseExact(t[2], "d/M/yyyy", null);
            soTC = int.Parse(t[3]);
        }

        public void Xuat()
        {
            Console.WriteLine($"{MaMH,-10}{TenMH,-15}{NgayDK.ToShortDateString(),-15}{SoTC,-10}");
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            MonHoc[] arr = new MonHoc[0];
            DocDS(ref arr, @"H:\CTDL&GT_K22\OnEXE1\input_De4- 2020.txt");
            XuatDS(arr);
            Console.WriteLine("Danh sach sau khi sap xep maMH tang dan dung BubbleSort: ");
            BubbleSort(arr);
            XuatDS(arr);
            Console.Write("Nhap maMH can sua tin chi: ");
            string key = Console.ReadLine();
            TimSua(arr, key);
            Console.WriteLine("Danh sach sau khi sap xep SoTC giam dan dung SelectionSort: ");
            SelectionSort(arr);
            XuatDS(arr);

        }
        /// <summary>
        /// Cau e
        /// </summary>
        /// <param name="arr"></param>
        static void SelectionSort(MonHoc[]arr)
        {
            int max;
            for (int i = 0; i < arr.Length-1; i++)
            {
                max = i;
                for (int j = i+1; j < arr.Length; j++)
                {
                    if (arr[max].SoTC < arr[j].SoTC)
                    {
                        max = j;
                    }
                }
                Swap(ref arr[max], ref arr[i]);
            }
        }
        /// <summary>
        /// Cau d
        /// </summary>
        /// <param name="arr"></param>
        /// <param name="key"></param>
        static void TimSua(MonHoc[] arr, string key)
        {
            int kq = TimNhiPhan(arr, key);
            if (kq == -1)
            {
                Console.WriteLine("Khong sua dc");
            }
            else
            {
                Console.Write("Cap nhat lai SoTC moi: ");
                arr[kq].SoTC = int.Parse(Console.ReadLine());
                Console.WriteLine("Danh sach sau khi cap nhat: ");
                XuatDS(arr);
            }
        }
        /// <summary>
        /// Ham tim Nhi phan
        /// </summary>
        /// <param name="arr"></param>
        /// <param name="key"></param>
        /// <returns></returns>
        static int TimNhiPhan(MonHoc[]arr, string key)
        {
            int left = 0, right = arr.Length - 1, mid = 0;
            while (left <= right)
            {
                mid = (left + right) / 2;
                if (arr[mid].MaMH == key)
                {
                    return mid;
                }
                else if (String.Compare(arr[mid].MaMH, key) < 0)
                {
                    left = mid + 1;
                }
                else
                {
                    right = mid - 1;
                }
            }
            return -1;
        }
        /// <summary>
        /// Cau c
        /// </summary>
        /// <param name="arr"></param>
        static void BubbleSort(MonHoc[]arr)
        {
            for (int i = 0; i < arr.Length-1; i++)
            {
                for (int j = arr.Length-1; j > i; j--)
                {
                    if (String.Compare(arr[j].MaMH, arr[j-1].MaMH) < 0)
                    {
                        Swap(ref arr[j], ref arr[j - 1]);
                    }
                }
            }
        }
        static void Swap(ref MonHoc a, ref MonHoc b)
        {
            MonHoc tam = a;
            a = b; b = tam;
        }
        /// <summary>
        /// Cau b
        /// </summary>
        /// <param name="arr"></param>
        static void XuatDS(MonHoc[]arr)
        {
            Console.WriteLine($"{"MaMH",-10}{"TenMH",-15}{"NgayDK",-15}{"SoTC",-10}");
            for (int i = 0; i < arr.Length; i++)
            {
                arr[i].Xuat();
            }
        }
        /// <summary>
        /// Cau a
        /// </summary>
        /// <param name="arr"></param>
        /// <param name="path"></param>
        static void DocDS(ref MonHoc[]arr, string path)
        {
            try
            {
                using (StreamReader sr = new StreamReader(path))
                {
                    int n = int.Parse(sr.ReadLine());
                    arr = new MonHoc[n];
                    for (int i = 0; i < arr.Length; i++)
                    {
                        MonHoc mh = new MonHoc();
                        mh.Doc(sr);
                        arr[i] = mh;
                    }
                }
            }
            catch (Exception)
            {

                throw new Exception("Mo file that bai!!!");
            }
        }
        
    }
}
