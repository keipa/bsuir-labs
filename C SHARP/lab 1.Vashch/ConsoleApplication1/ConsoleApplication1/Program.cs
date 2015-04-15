using System;

namespace onedot
{
    public class onedot
    {
        public static int mpx = 5;
        public static int mpy = 5;
        public static char[,] field = new char[9, 18];
        public static int bpxc = 7;
        public static int bpyc = 3;
        public const char empty_p = '\u25cb';
        public const char full_p = '\u25cf';
        public const char pointer = '\u2687';
        public const char bad_point = '\u2742';
        public static Random bad_rund = new Random();
        public static int back_value;
        public static bool game_cond;

        public static void Main()
        {
            //Random bad_point_x = new Random();
            //  Random bad_point_y = new Random();
            ConsoleKeyInfo actkey;

            for (int i = 0; i <= 8; i++)
            {
                for (int j = 0; j <= 17; j++)
                {
                    field[i, j] = empty_p;
                }

            }

            // int bpy = bad_point_y.Next(2,5);
            // int bpx = bad_point_x.Next(6,12);

            bad_rund.Next(1, 8);

            // bpxc = bpx;
            // bpyc = bpy;

            field[bpyc, bpxc] = bad_point;
            redraw();
            actkey = Console.ReadKey();
            while ((actkey.Key != ConsoleKey.Escape) || !game_cond)
            {
                actkey = Console.ReadKey();
                if (actkey.Key == ConsoleKey.A)
                {
                    moveleft(mpx, mpy, pointer);
                    mpx = back_value;
                }
                if (actkey.Key == ConsoleKey.D)
                {
                    moveright(mpx, mpy, pointer);
                    mpx = back_value;
                }
                if (actkey.Key == ConsoleKey.W)
                {
                    moveup(mpx, mpy, pointer);
                    mpy = back_value;
                }
                if (actkey.Key == ConsoleKey.S)
                {
                    movedown(mpx, mpy, pointer);
                    mpy = back_value;
                }
                if (actkey.Key == ConsoleKey.Enter) setpoint();

            }

            if (game_cond)
            {
                Console.SetCursorPosition(50, 25);
                Console.WriteLine("You win!");
            }
            else
            {
                Console.SetCursorPosition(50, 25);
                Console.WriteLine("You lose!");
            }


        }

        public static void redraw()
        {
            for (int i = 0; i <= 8; ++i)
            {
                for (int j = 0; j <= 17; ++j)
                {
                    Console.SetCursorPosition(j, i);
                    Console.WriteLine(field[i, j]);
                }
            }
        }
        public static void moveleft(int px, int py, char tpoint)
        {
            if (!(px - 1 < 0))
            {
                --px;
                redraw();
                Console.SetCursorPosition(px, py);
                Console.WriteLine(tpoint);
                back_value = px;
            }
        }

        public static void moveright(int px, int py, char tpoint)
        {
            if (!(px + 1 > 17))
            {
                ++px;
                redraw();
                Console.SetCursorPosition(px, py);
                Console.WriteLine(tpoint);
                back_value = px;
            }
        }

        public static void moveup(int px, int py, char tpoint)
        {
            if (!(py - 1 < 0))
            {
                --py;
                redraw();
                Console.SetCursorPosition(px, py);
                Console.WriteLine(tpoint);
                back_value = py;
            }
        }

        public static void movedown(int px, int py, char tpoint)
        {
            if (!(py + 1 > 8))
            {
                ++py;
                redraw();
                Console.SetCursorPosition(px, py);
                Console.WriteLine(tpoint);
                back_value = py;
            }
        }

        public static void setpoint()
        {
            if (!((bpxc == mpx) && (bpyc == mpy)))
            {
                field[mpy, mpx] = full_p;
                redraw();
                victory_check();
            }
        }

        public static void bad_point_move()
        {
            switch (bad_rund.Next(1, 8))
            {
                case 1:       //left
                    if (!(bpxc - 1 < 0))
                    {
                        moveleft(bpxc, bpyc, bad_point);
                    }
                    break;
                case 2:       //right
                    if (!(bpxc + 1 > 17))
                    {
                        moveright(bpxc, bpyc, bad_point);
                    }
                    break;
                case 3:       //up
                    if (!(bpxc - 1 < 0))
                    {
                        moveleft(bpxc, bpyc, bad_point);
                    }
                    break;

                case 4:       //down
                    if (!(bpxc + 1 > 8))
                    {
                        moveleft(bpxc, bpyc, bad_point);
                    }
                    break;
            }
        }
        public static void victory_check()
        {
            if ((field[bpxc - 1, bpyc] == full_p) && (field[bpxc + 1, bpyc] == full_p) && (field[bpxc, bpyc - 1] == full_p) && (field[bpxc, bpyc + 1] == full_p))
            {
                game_cond = true;
            }
            else
            {
                game_cond = false;
            }
        }
    }
}