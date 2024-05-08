import type { SVGAttributes } from 'react';
import Image from 'next/image';

// export type LogoProps = SVGAttributes<SVGSVGElement>;

export const Logo = ({ ...props }) => {
  return (
    <Image src={"https://i.ibb.co/0ckg2BH/Logo.png"} alt="Snapsign Logo" className="rounded-md" width={80} height={40} />
  );
};
