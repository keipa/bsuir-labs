using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

using System.Collections;

namespace WpfApplication1
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        Test One = CreateCollection();
        int indexforoutput = 0;
        float resultmark = 0;
        
        public MainWindow()
        {
            InitializeComponent();
            TreeView.Items.Clear();
            Available.Content = "0";
            Average.Content = "0";
            
        }

        public void Button_Click(object sender, RoutedEventArgs e)
        {
            /*
             add own elenemt
             */
            if (EditQuestion.Text == "")
            {
                return;
            }

            One.Addown(EditQuestion.Text, EditVar1.Text, (bool)ch1.IsChecked, EditVar2.Text, (bool)ch2.IsChecked, EditVar3.Text, (bool)ch3.IsChecked, EditVar4.Text, (bool)ch4.IsChecked, EditVar5.Text, (bool)ch5.IsChecked, Convert.ToInt32(DiffCombo.SelectedIndex+1));
            Average.Content = (string)One.GetAverage();
            Available.Content = One.GetCount();
            TreeView.Items.Add(new TreeViewItem().Header = EditQuestion.Text);
            EditQuestion.Clear();
            EditVar1.Clear(); ch1.IsChecked = false;
            EditVar2.Clear(); ch2.IsChecked = false;
            EditVar3.Clear(); ch3.IsChecked = false;
            EditVar4.Clear(); ch4.IsChecked = false;
            EditVar5.Clear(); ch5.IsChecked = false;
           // TreeView.Items.Add(new TreeViewItem().Header = "Hi");
        }

        public static Test CreateCollection()
        {
            Test One = new Test();
            return One;
        }

        
        public void Autoadd (){
            bool c = true;
            bool i = false;
            string q1 = "What's included in a typical software packade";
            string q1v1 = "distribution media";
            string q1v2 = "information about its system requirements";
            string q1v3 = "validation code";
            string q1v4 = "software copyrights";
            int q1d = 4;
            One.Addown(q1, q1v1,c, q1v2,i, q1v3,i, q1v4,i, null,i, q1d);

            string q2 = "Military must";
            string q2v1 = "be healthy";
            string q2v2 = "be accurate";
            string q2v3 = "be safe";
            string q2v4 = "be strong";
            string q2v5 = "be frighten";
            int q2d = 4;
            One.Addown(q2, q2v1, i, q2v2, i, q2v3, i, q2v4, c, q2v5, i, q2d);

            string q3 = "Never gonna...";
            string q3v1 = "make you cry";
            string q3v2 = "give you up";
            string q3v3 = "let you down";
            string q3v4 = "say goodbuy";
            string q3v5 = "tell a lie and hurt you";
            int q3d = 1;
            One.Addown(q3, q3v1, i, q3v2, i, q3v3, i, q3v4, c, q3v5, i, q3d);
    }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            Autoadd();
            Average.Content = (string)One.GetAverage();
            Available.Content = One.GetCount();
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            Available.Content = "0";
            Average.Content = "0";
            One.Clear();
            TreeView.Items.Clear();
        }

        private void Button_Click_3(object sender, RoutedEventArgs e)
        {
            resultmark = 0;
            //TC.Items.Add()
            if (Available.Content == "0")
            {
                return;
            }

            MakeButtonsIsEnabled(false);
            window.Height = 625d;
            AchClear();
            QuestionShow(indexforoutput);
            

        }

        private void QuestionShow(int index)
        {
            Ach1.IsEnabled = true;
            Ach2.IsEnabled = true;
            Ach3.IsEnabled = true;
            Ach4.IsEnabled = true;
            Ach5.IsEnabled = true;
            QuestionTitle.Content = One.GetQuestion(index).Name;
            foreach (Variant v in One.GetQuestion(index))
            {
                if (Ach1.Content == "")
                {
                    Ach1.Content = v.Name;
                    continue;
                }
                if (Ach2.Content == "")
                {
                    Ach2.Content = v.Name;
                    continue;
                }
                if (Ach3.Content == "")
                {
                    Ach3.Content = v.Name;
                    continue;
                }
                if (Ach4.Content == "")
                {
                    Ach4.Content = v.Name;
                    continue;
                }
                if (Ach5.Content == "")
                {
                    Ach5.Content = v.Name;
                    continue;
                }
            }
            if (Ach5.Content == "")
            {
                Ach5.IsEnabled = false;
            }
            else
            {
                return;
            }
            if (Ach4.Content == "")
            {
                Ach4.IsEnabled = false;
            }
            else
            {
                return;
            }
            if (Ach3.Content == "")
            {
                Ach3.IsEnabled = false;
            }
            else
            {
                return;
            }
            if (Ach2.Content == "")
            {
                Ach2.IsEnabled = false;
            }
            else
            {
                return;
            }
        }

        private void MakeButtonsIsEnabled(bool YN)
        {
            Start.IsEnabled = YN;
            AutoaddButton.IsEnabled = YN;
            ClearButton.IsEnabled = YN;
            AddButton.IsEnabled = YN;
            DiffCombo.IsEnabled = YN;
            EditQuestion.IsEnabled = YN;
            EditVar1.IsEnabled = YN;
            EditVar2.IsEnabled = YN;
            EditVar3.IsEnabled = YN;
            EditVar4.IsEnabled = YN;
            EditVar5.IsEnabled = YN;
            ch1.IsEnabled = YN;
            ch2.IsEnabled = YN;
            ch3.IsEnabled = YN;
            ch4.IsEnabled = YN;
            ch5.IsEnabled = YN;
        }

        private void Button_Click_4(object sender, RoutedEventArgs e)
        {
            InitTest();
            
        }
        private bool IsLastCorrect()
        {
            if (!Ach1.IsEnabled || Ach1.IsEnabled && One.GetQuestion(indexforoutput).GetVariant(0).Ans && (bool)Ach1.IsChecked
                || Ach1.IsEnabled && !One.GetQuestion(indexforoutput).GetVariant(0).Ans && !(bool)Ach1.IsChecked)
            {
                if (!Ach2.IsEnabled || Ach2.IsEnabled && One.GetQuestion(indexforoutput).GetVariant(1).Ans && (bool)Ach2.IsChecked
                    || Ach2.IsEnabled && !One.GetQuestion(indexforoutput).GetVariant(1).Ans && !(bool)Ach2.IsChecked)
                {
                    if (!Ach3.IsEnabled || Ach3.IsEnabled && One.GetQuestion(indexforoutput).GetVariant(2).Ans && (bool)Ach3.IsChecked
                        || Ach3.IsEnabled && !One.GetQuestion(indexforoutput).GetVariant(2).Ans && !(bool)Ach3.IsChecked)
                    {
                        if (!Ach4.IsEnabled || Ach4.IsEnabled && One.GetQuestion(indexforoutput).GetVariant(3).Ans && (bool)Ach4.IsChecked
                            || Ach4.IsEnabled && !One.GetQuestion(indexforoutput).GetVariant(3).Ans && !(bool)Ach4.IsChecked)
                        {
                            if (!Ach5.IsEnabled || Ach5.IsEnabled && One.GetQuestion(indexforoutput).GetVariant(4).Ans && (bool)Ach5.IsChecked
                                || Ach5.IsEnabled && !One.GetQuestion(indexforoutput).GetVariant(4).Ans && !(bool)Ach5.IsChecked)
                            {
                                return true;
                            }
                        }
                    }
                }
            }
            return false;
        }
        private void InitTest()
        {
            if (QuestionTitle.Content != "")
            {
                //проверка на правильность
                if (IsLastCorrect())
                {
                   resultmark += (100 / One.GetCount());
                }                
            }

            if (NextButton.Content == "Finish")
            {
                window.Height = 345d;
                NextButton.Content = "Next";
                MakeButtonsIsEnabled(true);
                indexforoutput = 0;
                Result.Content = "Your result is "+ (resultmark+1) + "%";
                return;
            }
            AchClear();
            ++indexforoutput;
            QuestionShow(indexforoutput);
            if (indexforoutput == One.GetCount() - 1)
            {
                //вывести результат теста
                //поднять форму
                NextButton.Content = "Finish";
                //return;
            }

        }

        private void AchClear()
        {
            Ach1.Content = "";
            Ach2.Content = "";
            Ach3.Content = "";
            Ach4.Content = "";
            Ach5.Content = "";
            Ach1.IsChecked = false;
            Ach2.IsChecked = false;
            Ach3.IsChecked = false;
            Ach4.IsChecked = false;
            Ach5.IsChecked = false;

        }
    }



    public class Test : IEnumerable<Question>
    {
        private List<Question> current;
        public bool IsReadOnly { get; set; }


        public Test()
        {
            current = new List<Question>();
        }
       // public void Autoadd();

        public string GetAverage()
        {
            
            int s = 0;
            string outs;
            foreach(Question i in current){
                s += i.Difficulty;
            }
            s = s / current.Count;
            outs = Convert.ToString(s);
            return outs;
        }

        public int GetCount()
        {
            int s = 0;
            string outs;
             s = current.Count;
            //outs = Convert.ToString(s);
            return s;

        }
        public Question GetQuestion(int c)
        {
            return current[c];
        }

        public void Addown(string q, string v1, bool c1, string v2, bool c2, string v3, bool c3, string v4, bool c4, string v5, bool c5, int diff)
        
        {
            
            Question oq = new Question(q, diff);
            current.Add(oq);
            if (v1 != null)
            {
                Variant NV1 = new Variant(v1,c1);
                oq.Add(NV1);

                if (v2 != null)
                {
                    Variant NV2 = new Variant(v2,c2);
                    oq.Add(NV2);

                    if (v3 != null)
                    {
                        Variant NV3 = new Variant(v3,c3);
                        oq.Add(NV3);

                        if (v4 != null)
                        {
                            Variant NV4 = new Variant(v4,c4);
                            oq.Add(NV4);

                            if (v5 != null)
                            {
                                Variant NV5 = new Variant(v5,c5);
                                oq.Add(NV5);
                            }
                        }
                    }
                }
            }
            //Console.WriteLine("do you gonna add variants? y/n");
            //int YNsw = Convert.ToInt32(Console.ReadLine());

           /* while (YNsw != 0)
            {
                if (YNsw == 1)
                {
                    
                    //Console.WriteLine("Input Variant: ");
                    //ovname = Console.ReadLine();
                    //Variant ov = new Variant(ovname);
                    //oq.Add(ov);
                    //Console.WriteLine("More? y/n");

                }
                //YNsw = Convert.ToInt32(Console.ReadLine());

            }*/
        }

        public void Add(Question q)
        {
            current.Add(q);

            if (current.Count > 1 && current[current.Count - 1].Difficulty < current[current.Count - 2].Difficulty)
            {
                Console.WriteLine("Difficulty is less than previous!!");
                current.Remove(q);

            }


        }



        public void Clear()
        {
            current.Clear();
        }


        public bool Contains(Question q)
        {
            return current.Contains(q);
        }


        public bool Remove(Question q)
        {

            return current.Remove(q);
        }

        public void CopyTo(Question[] q, int index)
        {
            current.CopyTo(q, index);
        }


        public IEnumerator<Question> GetEnumerator()
        {
            foreach (Question i in current)
            {
                yield return i;
            }
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }

    }
    public class Question : IEnumerable<Variant>
    {
        public int Count { get; set; }
        public bool IsReadOnly { get; set; }
        public string Name { get; set; }
        public int Difficulty { get; set; }
        private List<Variant> current;

        public Variant GetVariant(int c)
        {
            return current[c];
        }

        public Question(string name, int difficulty)
        {
            current = new List<Variant>();
            Name = name;
            Difficulty = difficulty;
        }


        public void Add(Variant q)
        {

            current.Add(q);
        }



        public void Clear()
        {
            current.Clear();
        }


        public bool Contains(Variant q)
        {
            return current.Contains(q);
        }


        public bool Remove(Variant q)
        {
            --Count;
            return current.Remove(q);
        }

        public void CopyTo(Variant[] q, int index)
        {
            current.CopyTo(q, index);
        }







        public IEnumerator<Variant> GetEnumerator()
        {
            foreach (Variant i in current)
            {
                yield return i;
            }
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }


    }
    public class Variant
    {
        public string Name;
        public bool Ans;

        /*
         * 
         * 0 - incorrect;
         * 1 - correct;
         * 
         */

        public Variant(string name, bool ans)
        {
            Ans = ans;
            Name = name;
        }

    }
}